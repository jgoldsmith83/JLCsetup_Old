import sys
from subprocess import call
from Tkinter import *

def get_choice():
    global _do
    _do = raw_input("> ")
    #return _do

def parse_choice():
    if _do == "1":
        #exec("python resmake.py")
        print "Thing 1"
    elif _do == "2":
        #exec("python resundo.py")
        print "Thing 2"
    elif _do == "3":
        call(['clear'])
        quit()
    else:
        print "Invalid option..."
        #menu()

def display_menu():
    call(['clear'])
    
    print "Select option:\n\n"
    print "1. New Setup\n2. Undo Setup\n3. Exit"
    #get_choice()
    #parse_choice()

def do_it():
    print "It works"



#display_menu()
#get_choice()
#parse_choice()

root = Tk()
root.title("Palmetto Goodwill")
root.geometry("300x150")
#root.wm_iconbitmap('GW_icon.ico')

title = LabelFrame(root,text="JLC Ubuntu Setup")
title.pack()

new_frame = Frame(title)
new_frame.pack()
new = Button(new_frame,text="New Setup",command=do_it)
new.pack()

undo_frame = Frame(title)
undo_frame.pack()
undo = Button(undo_frame,text="Undo Setup")
undo.pack()

exit_frame = Frame(title)
exit_frame.pack()
exit = Button(exit_frame,text="exit")
exit.pack()

root.mainloop()

