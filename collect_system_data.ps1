
#New-Item C:\User\Alex\Desktop\test.txt -type file -force
#Set-Content -Path "C:\User\Alex\Desktop\test.txt" -Value "my test" -Force

#Get the PC Uptime
function Get-Uptime {
  $date = Get-Date
  $timeZone = Get-TimeZone
  $os = Get-WmiObject win32_operatingsystem
  $time = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
  # Print get time table
  $border = "----------------------------------------------------"
  Write-host "`n$border`n Get Time |`n$border"
  Write-host " Current time: " $date
  Write-host " Time Zone: " $timeZone
  Write-host " Uptime: " $($time.Days) "days :" $($time.Hours) "hours:" $($time.Minutes) "minutes"
  Write-host "$border`n"
}
#Get the Windows Version
function Get-WinVersion {
  $version = [System.Environment]::OSVersion.Version
  $typicalName = (Get-WmiObject -class Win32_OperatingSystem).Caption
  # Print the windows version table
  $border = "----------------------------------------------------"
  Write-host "`n$border`n Windows Version |`n$border"
  Write-host " Typical Name: " $typicalName
  Write-host " Major: " $version.Major
  Write-host " Minor: " $version.Minor
  Write-host " Build: " $version.Build
  Write-host " Revision: "$version.Revision
  Write-host "$border`n"
}
#Get the System hardware specs
function Get-Hardware {
  $hardware = Get-WmiObject Win32_Processor
  $cpuInfo = $hardware.name
  $totalMemory = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -sum
  $ramAmount = $totalMemory.sum
  $diskDrive = Get-WmiObject Win32_DiskDrive
  $HDDAmount = $diskDrive.Partitions
  # Print the System hardware specs table
  $border = "----------------------------------------------------"
  Write-host "`n$border`n System Hardware Specs |`n$border"
  Write-host " CPU Info: " $cpuInfo
  Write-host " Total Memory: " $totalMemory
  Write-host " RAM Amount: " $ramAmount
  Write-host " Disk Drive: " $diskDrive
  Write-host " HDD Amount: "$HDDAmount
  Write-host "$border`n"
}
# Get Domain Controller Information
function Get-DomainInfo{
  $hostName = (Get-WmiObject Win32_ComputerSystem).DNSHostName
  $Domain = (Get-WmiObject Win32_ComputerSystem).Domain
  # Print the windows version table
  $border = "----------------------------------------------------"
  Write-host "`n$border`n Domain Information |`n$border"
  Write-host " Host Name: " $hostName
  Write-host " Domain: " $Domain
  Write-host "$border`n"
}
# List of Local Users
#funtion Get-Users {
  # Domain users include SID of user, user account creation date, last login

  # System users include SID of user, user account creation date, last login
  # Service users
  # Get user login history
#  $AllLocalAccounts = Get-WmiObject -Class Win32_UserAccount
#  Foreach $LocalAccount in $AllLocalAccounts{

#  }
#}
# Get Start at boot processes
function Get-BootProcesses{
  #Services
  $serviceNames = Get-WmiObject Win32_Service -Filter "StartMode = 'Auto'" | Select DisplayName
  # Registry location
  $registryLocation = Get-WmiObject Win32_BootConfiguration | Select BootDirectory
  # Print the windows version table
  $border = "----------------------------------------------------"
  Write-host "`n$border`n Boot Processes |`n$border"
  Write-host " Services: " $serviceNames
  Write-host " Registry Location: " $registryLocation
  Write-host "$border`n"
}
# Get tasks
function Get-Tasks {
  $tasks = Get-ScheduledTask
  # print get tasks
  $border = "----------------------------------------------------"
  Write-host "`n$border`n Scheduled Tasks |`n$border"
  Write-host " Tasks: "
   $tasks.TaskName
  Write-host "$border`n"
}
# Get Network information
function Get-NetworkInfo{
  # Get ARP table
  $arpTable = ARP -a
  # MAC addresses for all interfaces
  # Routing table
  # IP address (IPv4 and IPv6) for all interfaces
  $Config = Get-WmiObject Win32_NetworkAdapterConfiguration
  $ipAddresses = $Config.IPAddress
  # Get DHCP server
  $DHCPServer = $Config.DHCPServer
  # Get DNS server
  $DNSServer = $Config.DNSServer
  # Get DNS cache
  $DnsCache = Get-DnsClientCache
  # Print Networking Items
  $border = "----------------------------------------------------"
  Write-host "`n$border`n Network Information |`n$border"
  Write-host " ARP Table: "
  $arpTable
  Write-host " IP address's: " $ipAddresses
  Write-host " DHCP Server: " $DHCPServer
  Write-host " DNS Server: " $DNSServer
  Write-host " DNS Cache: " $DnsCache
  Write-host "$border`n"
}
# Driver list
function Get-DriverList {

}
# Network shares printers
function Get-NetworkItems {
  $printer = get-WmiObject -class Win32_printer

  # print the Network sharing
  $border = "----------------------------------------------------"
  Write-host "`n$border`n Boot Processes |`n$border"
  Write-host " Printers: "
  $printer.name
  Write-host "$border`n"
}

# Extra Function Make your ouwn
function Get-Bios{
  $biosInfo = Get-WmiObject Win32_BIOS
}

function PrintTable{
  Get-Uptime | Export-Csv -Path "Artifacts.csv"
  Get-WinVersion | Export-Csv -Path "Artifacts.csv"
  Get-Hardware | Export-Csv -Path "Artifacts.csv"
  Get-DomainInfo | Export-Csv -Path "Artifacts.csv"
  #Get-Users
  Get-BootProcesses | Export-Csv -Path "Artifacts.csv"
  Get-Tasks | Export-Csv -Path "Artifacts.csv"
  Get-NetworkInfo | Export-Csv -Path "Artifacts.csv"
  Get-DriverList | Export-Csv -Path "Artifacts.csv"
  Get-NetworkItems | Export-Csv -Path "Artifacts.csv"
}

PrintTable
