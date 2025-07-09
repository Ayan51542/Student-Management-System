# Student-Management-System
Student Management System This project is a Student Management System created in Assembly language. It provides a command-line interface for an administrator to manage student records efficiently. 

A command-line based Student Management System built in Assembly language. This application provides administrators with essential functionalities to manage student records, including creating, searching, modifying, and deleting student information through a secure login interface. Each record is stored in a separate text file for efficient, low-level data handling.

# Project Aim
The primary goal of this project is to provide an institution with a simple and systematic way to manage student records. It allows for the storage, retrieval, modification, and deletion of student information.

# Features
The system includes the following core features:
Admin Login: A secure login system for the administrator to access the management functions.
Add New Record: Insert new student records, including details like name, roll number, course, email, contact number, and address.
Search Record: Search for a specific student's record using their unique roll number.
Modify Record: Update the information of an existing student record.
Delete Record: Remove a student's record from the system.

# How It Works
The application is built entirely in low-level Assembly language, making it highly efficient. It uses a file-based storage system where each student's record is saved in a separate .txt file. The filename corresponds to the student's roll number, ensuring a unique identifier for each record.
The program's logic is organized into distinct procedures for handling different tasks.

# Procedures Used
ISLOGGEDIN PROC: Manages user authentication. It prompts for a username and password and validates them against stored credentials.
MENU PROC: Displays the main menu to the user, allowing them to select an operation (Add, Search, Modify, Delete, Exit).
INSERT PROC: Gathers student details from the user and writes them to a new .txt file.
SEARCH PROC: Prompts for a roll number, locates the corresponding file, reads its contents, and displays the student's details.
MODIFY PROC: Allows the user to overwrite the details in an existing student's file.
DELETE PROC: Deletes the file associated with a given roll number, effectively removing the student's record.

# Future Plans
This project has the potential for further development. Future enhancements could include:
Calculating student grades.
Tracking the number of courses a student has taken.
Recording attendance for respective courses.
