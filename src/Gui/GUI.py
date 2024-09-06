import customtkinter as ctk
import tkinter as tk
from tkinter import messagebox
from py4j.java_gateway import JavaGateway
import threading

gateway = JavaGateway()
entry_point = gateway.entry_point

def run_query(query_number):
    result_text.delete(1.0, ctk.END)
    update_status("Running query...")
    try:
        output = ""
        if query_number == 1:
            output = entry_point.query1()
        elif query_number == 2:
            output = entry_point.query2()
        elif query_number == 3:
            output = entry_point.query3()
        elif query_number == 4:
            output = entry_point.query4()
        elif query_number == 5:
            output = entry_point.query5()
        elif query_number == 6:
            output = entry_point.query6()
        result_text.insert(ctk.END, output + '\n')
    except Exception as e:
        messagebox.showerror("Error", f"An error occurred: {e}")
    finally:
        update_status("Ready")

def run_query_async():
    query_number = query_options.index(query_var.get()) + 1
    threading.Thread(target=run_query, args=(query_number,)).start()

def update_status(text):
    status_var.set(text)

def about():
    messagebox.showinfo("About", "Admin Menu GUI\nVersion 1.0\nPowered by Py4J and customtkinter")

root = ctk.CTk()
root.title("Admin Menu")
root.geometry("700x500")
ctk.set_appearance_mode("System")
ctk.set_default_color_theme("blue")

status_var = ctk.StringVar(value="Ready")

menubar = tk.Menu(root)
root.config(menu=menubar)

file_menu = tk.Menu(menubar, tearoff=0)
file_menu.add_command(label="Exit", command=root.quit)
menubar.add_cascade(label="File", menu=file_menu)

help_menu = tk.Menu(menubar, tearoff=0)
help_menu.add_command(label="About", command=about)
menubar.add_cascade(label="Help", menu=help_menu)

button_frame = ctk.CTkFrame(root)
button_frame.grid(row=0, column=0, sticky="W", padx=10, pady=10)

ctk.CTkLabel(button_frame, text="Select a Query:").grid(row=0, column=0, padx=5, pady=5)

query_options = [
    "Query 1: All customers who have ordered a black T-shirt in size M",
    "Query 2: List categories with the number of products in each",
    "Query 3: List customers and how much they have spent",
    "Query 4: Fetch Customers",
    "Query 5: Fetch Orders",
    "Query 6: Fetch Products"
]

query_var = ctk.StringVar(value=query_options[0])
query_combobox = ctk.CTkComboBox(button_frame, values=query_options, variable=query_var, width=450)
query_combobox.grid(row=1, column=0, padx=5, pady=5)

send_button = ctk.CTkButton(button_frame, text="Send Query", command=run_query_async)
send_button.grid(row=1, column=1, padx=5, pady=5)

result_frame = ctk.CTkFrame(root)
result_frame.grid(row=1, column=0, sticky="nsew", padx=10, pady=10)

root.grid_rowconfigure(1, weight=1)
root.grid_columnconfigure(0, weight=1)

result_text = ctk.CTkTextbox(result_frame, wrap='word')
result_text.grid(row=0, column=0, padx=5, pady=5, sticky="nsew")

scrollbar = ctk.CTkScrollbar(result_frame, orientation="vertical", command=result_text.yview)
scrollbar.grid(row=0, column=1, sticky="ns")
result_text.configure(yscrollcommand=scrollbar.set)

result_frame.grid_rowconfigure(0, weight=1)
result_frame.grid_columnconfigure(0, weight=1)

status_bar = ctk.CTkLabel(root, textvariable=status_var, anchor='w')
status_bar.grid(row=2, column=0, sticky="we", padx=5, pady=5)

root.columnconfigure(0, weight=1)
root.rowconfigure(1, weight=1)

root.mainloop()