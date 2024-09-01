from py4j.java_gateway import JavaGateway
import tkinter as tk

gateway = JavaGateway()
entry_point = gateway.entry_point

def run_query(query_number):
    result_text.delete(1.0, tk.END)
    output = ""

    if query_number == 1:
        output = entry_point.query1()
    elif query_number == 2:
        output = entry_point.query2()
    elif query_number == 3:
        output = entry_point.query3()

    result_text.insert(tk.END, output + '\n')

root = tk.Tk()
root.title("Admin Menu")

query1_button = tk.Button(root, text="Query 1", command=lambda: run_query(1))
query1_button.pack()

query2_button = tk.Button(root, text="Query 2", command=lambda: run_query(2))
query2_button.pack()

query3_button = tk.Button(root, text="Query 3", command=lambda: run_query(3))
query3_button.pack()

result_text = tk.Text(root, height=20, width=50)
result_text.pack()

root.mainloop()