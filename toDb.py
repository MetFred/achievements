import sqlite3 as sql
import json

def getTextId(cur, text, language_id=1):
    sqlText = text.replace("'", "''")
    cur.execute(f"SELECT id FROM texts WHERE language_id = {language_id} AND text = '{sqlText}'")
    id = cur.fetchone()
    id = id if id is None else id[0]
    if id is None:
        cur.execute(f"SELECT max(id) + 1 FROM texts")
        id = cur.fetchone()[0]
        cur.execute(f"INSERT INTO texts (id, language_id, text) VALUES ({id}, {language_id}, '{sqlText}')")
    return id

with sql.connect("Achievements.db") as con:
    cur = con.cursor()

    ## CREATE TABLES
    with open("initModel.sql", "r") as f:
        cur.executescript(f.read())

    ## CHECK TABLES
    cur.execute("SELECT name FROM sqlite_master WHERE type='table'")
    print("CHECK TABLES:")
    for r in cur.fetchall():
        print(r)

    ## ADD INITIAL DATA
    with open("initData.sql", "r") as f:
        cur.executescript(f.read())

    ## CHECK INITIAL DATA
    cur.execute("SELECT l.id, t.text FROM languages l JOIN texts t ON l.text_id = t.id AND t.language_id = 1")
    print("\nCHECK DATA:")
    for r in cur.fetchall():
        print(r)

    ## LOAD REAL DATA
    tagtypes = {}
    with open("tagtypes.json") as f:
        for k, v in json.load(f).items():
            nameId = getTextId(cur, k)
            descId = getTextId(cur, v)
            cur.execute(f"INSERT INTO tagtypes (text_id_name, text_id_desc) VALUES ({nameId}, {descId})")
            tagtypes[k] = cur.lastrowid

    tags = {}
    with open("tags.json") as f:
        for k, v in json.load(f).items():
            nameId = getTextId(cur, k)
            descId = getTextId(cur, v["desc"])
            tagtypeId = tagtypes[v["type"]]
            cur.execute(f"INSERT INTO tags (text_id_name, text_id_desc, tagtype_id) VALUES ({nameId}, {descId}, {tagtypeId})")
            tags[k] = cur.lastrowid

    with open("achievements.json") as f:
        for k, v in json.load(f).items():
            nameId = getTextId(cur, k)
            descId = getTextId(cur, "/")
            cur.execute(f"INSERT INTO achievements (text_id_name, text_id_desc, achievementtype_id) VALUES ({nameId}, {descId}, 1)")
            achievement_id = cur.lastrowid
            for tag in v["genres"] + v["tags"] + v["controls"] + v["platforms"]:
                tagId = tags[tag]
                cur.execute(f"INSERT INTO k_achievements_tags (achievement_id, tag_id) VALUES ({achievement_id}, {tagId})")

    ## CHECK DATA
    cur.execute("SELECT a.id, t.text FROM achievements a INNER JOIN texts t ON a.text_id_name = t.id AND t.language_id = 1")
    for a in cur.fetchall():
        innerCur = con.cursor()
        innerCur.execute(f"SELECT x.text FROM k_achievements_tags k INNER JOIN tags t ON k.tag_id = t.id INNER JOIN texts x ON t.text_id_name = x.id AND x.language_id = 1 WHERE k.achievement_id = {a[0]}")
        print(str(a[0]).ljust(5), a[1].ljust(60), ", ".join(sorted([t[0] for t in innerCur.fetchall()])))
        innerCur.close()

    cur.close()
