# Author: Alex Lunderman
# Powershell script to assist with Lab Three
# Must execute script in the same location as the timestomp executable

# add six files to the
New-Item E:/fileOne.txt -type file
Add-Content E:/fileOne.txt "This is test file One."
New-Item E:/fileTwo.txt -type file
Add-Content E:/fileTwo.txt "This is test file Two."
New-Item E:/fileThree.txt -type file
Add-Content E:/fileThree.txt "This is test file Three."
New-Item E:/fileFour.txt -type file
Add-Content E:/fileFour.txt "This is test file Four."
New-Item E:/fileFive.txt -type file
Add-Content E:/fileFive.txt "This is test file Five."
New-Item E:/fileSix.txt -type file
Add-Content E:/fileSix.txt "This is test file Six."

# Change the name of one of the files
Rename-Item -path E:/fileOne.txt -NewName E:/FileOneNewName.txt

# Change the content of one of the files
Add-Content E:/fileTwo.txt "New Content."

# Change the date of one of the files
./timestomp.exe E:/fileThree.txt -z "Monday 07/23/2007 3:54:26 PM"

# Delete one the files
Remove-Item E:/fileFour.txt

# Recreate deleted file with same but different name
New-Item E:/fileFour2.txt -type file
Add-Content E:/fileFour2.txt "This is test file Four."
