# Parking-Management
An application created for maintaining Parking of an organization. User-End application to register/login into the application and generate a QR Code of their Licence Plate which will be scanned at an automatic gate using QR Scanner.


-> Prerequisites 

1. Flutter Enviornment 

2. MySQL Enviornment with the following settings: username - "root", password - ""

3. Xampp: https://www.apachefriends.org/download.html

4. Python Enviornment


-> Steps to run the project

Step 1: Create a new project called 'parking_management_system'

Step 2: Now, inside the project folder: Replace the folder 'lib' and 'assets'. Replace the file 'pubspec.yaml' [NOTE: Let the pubspec.yaml file run in vscode and create the required dependencies'] 

Step 3: Inside the 'htdocs' folder of Xampp, paste the folder 'flutter_login_backend'

Step 4: Run Xampp and start Apache and MySQL Server

Step 5: Import the 'database.sql' file in your MySQL on your computer or just use phpmyadmin to import it. [visit localhost/phpmyadmin from your browser] 

Step 6: Now while the flutter project is open, type in the command 'flutter run' and select your appropriate method to run. [Windows Desktop Application Recommended] 

Step 7: Once the project runs successfully, you can type in 'flutter build ____' to generate an executable file for the application. [NOTE: The blankspace after flutter build refers to the operating system you are running, kindly check flutter documentation by just typing in 'flutter build' in the terminal] 


