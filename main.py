import sqlite3

conexao = sqlite3.connect("banco.db")
cursor = conexao.cursor()

cursor.execute("""CREATE TABLE IF NOT EXISTS contas_bancarias (
               id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
               titular TEXT NOT NULL,
               saldo FLOAT NOT NULL,
               cpf TEXT NOT NULL UNIQUE
               )""")

#conexao.execute("""INSERT INTO contas_bancarias 
#                (titular, saldo, cpf) VALUES 
#                ('Tay', -398, '31720036588')""")

cursor.execute("""SELECT * FROM contas_bancarias""")
#cursor.execute("""UPDATE contas_bancarias
#               SET saldo = -4000
#               WHERE id = 2""")
contas = cursor.fetchall()
print(contas)
print("\n")

for conta in contas:
    id, titular, saldo, cpf = conta
    print(f"""Id: {id}
Titular: {titular}
Saldo: {saldo}
CPF: {cpf}""")
    print("\n")

conexao.commit()