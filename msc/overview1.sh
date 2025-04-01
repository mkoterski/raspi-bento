# new start screen idea

Raspi Bento - Version 0.03                                   2025-01-18 - 13:58
calypso | Ubuntu 24.04.1 LTS | aarch64      Raspberry Pi 3 Model B Plus Rev 1.3

[1] Internet Test       Internet                    Local network
                        [x] Dependencies missing    


[2] CPU Test            CPU             Threads         Memory
                        [i] Running CPU test...





[3] Storage Test        Write speed                 Read speed
                        [✓] Ready                   [✓] Ready



Press number to run test single. Press 'a' to run all tests or 'q' to quit:



# new start screen idea

Raspi Bento - Version 0.03                                   2025-01-18 - 13:58
calypso | Ubuntu 24.04.1 LTS | aarch64      Raspberry Pi 3 Model B Plus Rev 1.3

[1] Internet Test       Internet                    Local network
                        [x] Install missing dependencies? (y/n)    


[2] CPU Test            CPU             Threads         Memory
                        [i] Running CPU test...





[3] Storage Test        Write speed                 Read speed
                        [✓] Ready                   [✓] Ready



Press number to run test or 'q' to quit:

# start screen

Raspi Bento - Version 0.03                                   2025-01-18 - 13:58
calypso | Ubuntu 24.04.1 LTS | aarch64      Raspberry Pi 3 Model B Plus Rev 1.3

1 - Internet Test       Internet                    Local network
                        [x] Dependencies missing    
                        



2 - CPU Test            CPU             Threads         Memory
                        [i] Running CPU test...






3 - SD Card Test        DD write speed              DD read speed
                        [✓] Ready                   [✓] Ready



# action screen

Raspi Bento - Version 0.03                                   2025-01-18 - 13:58
calypso | Ubuntu 24.04.1 LTS | aarch64      Raspberry Pi 3 Model B Plus Rev 1.3

1 - Internet Test       Internet                    Local network
                        [x] Dependencies missing
                        



2 - CPU Test            CPU             Threads         Memory
                        [i] Running CPU test...






3 - HDPARM Test         [✓] Ready

4 - SD Card Test        DD WRITE test               DD READ test
                        [i] Running DD WRITE test...
                        [i] Running DD READ test...       



# after running the script, the following output will be displayed

Raspi Bento - v0.04                                          2025-01-18 - 13:58
calypso | Ubuntu 24.04.1 LTS | aarch64      Raspberry Pi 3 Model B Plus Rev 1.3

1 - Internet Test       Internet                    Local network
                        Ping: 28.975 ms             Connection(s): eth0, wlan0
                        Download: 47.86 Mbit/s      Local IP: 192.168.1.132
                        Upload: 52.54 Mbit/s        Public IP: 80.12.34.88
2 - CPU Test            CPU             Threads         Memory
                        time: 10.0014s  time: 10.0133s  time: 1.4694s
                        min: 1.39       min: 54.33      min: 0.00
                        avg: 1.41       avg: 54.75      avg: 0.00
                        max: 2.02       max: 56.02      max: 0.34
                                                        3072.00 MiB transferred
                                                        (2070.30 MiB/sec)
3 - SD Card Test        DD WRITE test               DD READ test
                        537 MB / 512 MiB copied,    537 MB / 512 MiB copied,
                        52.8301 s, 10.2 MB/s        22.9001 s, 23.4 MB/s
                        max. read speed: 68 MB in  3.03 seconds =  22.44 MB/sec

Press number to run test or 'q' to quit:
                                           
                
# test without spacing

# after running the script, the following output will be displayed

Raspi Bento - v0.03                                          2025-01-18 - 13:58
calypso | Ubuntu 24.04.1 LTS | aarch64      Raspberry Pi 3 Model B Plus Rev 1.3

1 - Internet Test       Internet                    Local network
                        Ping: 28.975 ms             Connection(s): eth0
                        Download: 47.86 Mbit/s      Local IP: 192.168.1.132
                        Upload: 52.54 Mbit/s        Public IP: 80.12.34.88
2 - CPU Test            CPU             Threads         Memory
                        time: 10.0014s  time: 10.0133s  time: 1.4694s
                        min: 1.39       min: 54.33      min: 0.00
                        avg: 1.41       avg: 54.75      avg: 0.00
                        max: 2.02       max: 56.02      max: 0.34
                                                        3072.00 MiB transferred
                                                        (2070.30 MiB/sec)
3 - SD Card Test        68 MB in  3.03 seconds =  22.44 MB/sec
                        DD WRITE test               DD READ test
                        537 MB / 512 MiB copied,    537 MB / 512 MiB copied,
                        52.8301 s, 10.2 MB/s        22.9001 s, 23.4 MB/s
                                           






temp=46.2'C
arm_freq=1400
arm_freq_min=600
core_freq=400
sdram_freq=450
gpu_freq=300
sd_clock=50.000 MHz

Running InternetSpeed test...
Ping: 28.975 ms
Download: 47.86 Mbit/s
Upload: 52.54 Mbit/s

Running CPU test...
 total time: 10.0014s
 min: 1.39
 avg: 1.41
 max: 2.02





  [i] SELinux not detected
  [✓] Update local cache of available packages

  [✓] Checking apt-get for upgraded packages... 135 updates available
  [i] It is recommended to update your OS after installing the Pi-hole!

  [i] Checking for / installing Required dependencies for OS Check...
  [✓] Checking for grep
  [i] Checking for dnsutils (will be installed)
  [i] Waiting for package manager to finish (up to 30 seconds)
  [i] Processing apt-get install(s) for: dnsutils, p

Raspi Bento - Version 0.03                                    2025-01-18 - 13:58
calypso | Ubuntu 24.04.1 LTS | Raspberry Pi 3 Model B Plus Rev 1.3 | aarch64

temp=46.2'C
arm_freq=1400
arm_freq_min=600
core_freq=400
sdram_freq=450
gpu_freq=300
sd_clock=50.000 MHz

Running InternetSpeed test...
Ping: 28.975 ms
Download: 47.86 Mbit/s
Upload: 52.54 Mbit/s

Running CPU test...
 total time: 10.0014s
 min: 1.39
 avg: 1.41
 max: 2.02
temp=49.4'C

Running THREADS test...
 total time: 10.0133s
 min: 54.33
 avg: 54.75
 max: 56.02
temp=50.5'C

Running MEMORY test...
3072.00 MiB transferred (2070.30 MiB/sec)
 total time: 1.4694s
 min: 0.00
 avg: 0.00
 max: 0.34
temp=49.9'C

Running HDPARM test...
 Timing buffered disk reads:  68 MB in  3.03 seconds =  22.44 MB/sec
temp=47.8'C

Running DD WRITE test...
536870912 bytes (537 MB, 512 MiB) copied, 52.8301 s, 10.2 MB/s
temp=47.2'C

Running DD READ test...
536870912 bytes (537 MB, 512 MiB) copied, 22.9001 s, 23.4 MB/s
temp=47.2'C

Raspi Bento is done! 🍱