REM http://webcache.googleusercontent.com/search?q=cache:SjoPPpuQxuoJ:www.tcm.phy.cam.ac.uk/~mr349/cygwin_install.html+install+cygwin+ssh+commandline&cd=2&hl=nl&ct=clnk&gl=be&source=www.google.be

REM create the cygwin directory
cmd /c mkdir %SystemDrive%\cygwin
copy a:cygwin-setup.exe %SystemDrive%\cygwin

REM goto a temp directory
cd %SystemDrive%\windows\temp

REM run the installation
cmd /c a:/cygwin-setup.exe -q -R %SystemDrive%\cygwin -P openssh,openssl,curl,cygrunsrv,wget,rebase,vim,unzip -s http://cygwin.mirrors.pair.com

%SystemDrive%\cygwin\bin\bash -c 'PATH=/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin cygrunsrv -R sshd'

REM /bin/ash is the right shell for this command
cmd /c %SystemDrive%\cygwin\bin\ash -c /bin/rebaseall

cmd /c %SystemDrive%\cygwin\bin\bash -c 'PATH=/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin mkgroup -l'>%SystemDrive%\cygwin\etc\group

cmd /c %SystemDrive%\cygwin\bin\bash -c 'PATH=/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin mkpasswd -l'>%SystemDrive%\cygwin\etc\passwd

%SystemDrive%\cygwin\bin\sleep 1

%SystemDrive%\cygwin\bin\bash -c 'PATH=/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin /usr/bin/ssh-host-config -y -c "ntsecbinmode tty" -w "abc&&123!!" '

%SystemDrive%\cygwin\bin\sleep 2 

cmd /c if exist %Systemroot%\system32\netsh.exe netsh advfirewall firewall add rule name="SSHD" dir=in action=allow program="c:\cygwin\usr\sbin\sshd.exe" enable=yes

cmd /c if exist %Systemroot%\system32\netsh.exe netsh advfirewall firewall add rule name="ssh" dir=in action=allow protocol=TCP localport=22

%SystemDrive%\cygwin\bin\sleep 2

net start sshd

REM  Fix corrupt recycle bin
REM  http://www.winhelponline.com/blog/fix-corrupted-recycle-bin-windows-7-vista/
cmd /c rd /s /q c:\$Recycle.bin
