Ubuntu/Docker mit DotNet 
------------------------

### Übersicht 

    +---------------------------------------------------------------+
    !                                                               !	
    !    +--------------------+                                     !
    !    ! DotNet Umgebung    !                                     !       
    !    +--------------------+                                     !
    !                                                               !	
    ! Container                                                     !	
    +---------------------------------------------------------------+
    ! Container-Engine: Docker                                      !	
    +---------------------------------------------------------------+
    ! Gast OS: Ubuntu 16.04                                         !	
    +---------------------------------------------------------------+
    ! Hypervisor: VirtualBox                                        !	
    +---------------------------------------------------------------+
    ! Host-OS: Windows, MacOS, Linux                                !	
    +---------------------------------------------------------------+
    ! Notebook - Schulnetz 10.x.x.x                                 !                 
    +---------------------------------------------------------------+
    
### Beschreibung
    
Beispiel für eine Entwicklungsumgebung, hier Microsoft DotNet, in einem Docker Container.

**Builden:**

	cd /vagrant/dotnet
	docker build -t dotnetapp .

**Aufruf**

    docker run -it --rm dotnetapp
     
*Im Container:* 

    dotnet out/dotnetapp.dll
    
    	Hello World!

**Testen:**

Datei `Program.cs` editieren mittels `nano` oder `vi`.

	nano Program.cs
	
Inhalt `Program.cs`: 
	

	using System;
	
	namespace dotnetapp
	{
	    class Program
	    {
	        static void Main(string[] args)
	        {
	            Console.WriteLine("Hallo Welt!");
	        }
	    }
	}
	
Programm compilieren

	dotnet run
    
Details siehe [dotnet](https://store.docker.com/images/dotnet?tab=description) im Kapitel `Interactively build and run a simple .NET Core application`