function checkFile(filename) {
    if (system("test -f "filename) == 0 ) {return 0} else {return 1}
}

function foo() {
    if(intname !~ /bond/){
        devfile="/sys/class/net/"intname"/device"
        cmdsub="ls -l "devfile "2>/dev/null"
        cmdsub | getline devlink
        close(cmdsub)
        split(devlink,tmp,"/");
        a1[intname,"pci"]="/"tmp[length(tmp)]
        speedfile="/sys/class/net/"intname"/speed"
        if ((getline speed < speedfile > 0)) {
            speed=speed/1000
            a1[intname,"speed"]=speed"G"
        }
    else {}
    }
}

BEGIN {
    id = 0 
    if (checkFile("/usr/bin/ip") == 0) {ipcmd="/usr/bin/ip"}
    else if (checkFile("/sbin/ip") {ipcmd="/sbin/ip"}
    else {print "Error! IP Command not found [/usr/bin/ip or /sbin/ip]\n Check if \"iproute\" rpm exists"; exit}

    cmd=ipcmd" -o link show"
    while((cmd | getline ) > 0) {
        intname = $2
        id++
        gsub(/:$/,"",intname)
        intArray[id]=intname
        a1[intname,"name"]=intname
        a1[intname,"ip"];
        foo()
        if (intname!~/bond/) {if ($0 ~ /bond[0-9]*/){
            ethfile="/sys/class/net"intname"/bonding_slave/perm_hwaddr"
            getline pmac < ethfile
            a1[intname,"pmac"]=pmac
        }
        }
        for (i=3;i<=NF;i++) {
            if($i~/link\/ether/) {a1[intname,"mac"]=$(i+1)}
            if ($i~/state/) {a1[intname,"state"]=$(i+1)}
            if ($i~/bond[0-9]*/) {a1[intname,"bond"]=$(i)}
        }
    }    
    close(cmd)
    if (ARGV[1])=="-4" {
        print "Filter ipv4(-4):","Yes"
        cmd=ipcmd" -o -4 addr show"
    } else {
        print "Filter ipv4(-4):","No"
        cmd=ipcmd" -o addr show"
    }
    while ((cmd|getline) > 0) {
        intname=$2
        gsub(/:$/,"",intname)
        if ($3 ~ /inet/) {
            if (a1[intname,"ip"]=="") {
                a1[intname,"ip"]==$(4)
            } else {
                a1[intname,"ip"]==a1[intname,"ip"]","$(4)
            }
        }
    }
    close(cmd)
    print "____________________________________________________________"
    print "%15s\t%6s\t%5s\t%20s\t%20s\t%10s\t%18s\n","Device","Name","Bond","Mac","Mac(perm)","State","Ip/Net"
    print "____________________________________________________________"
    for (x=1;x<length(intArray);x++) {
        i=intArray[x]
        state=a1[i,"state"]"("a1[i,"speed"]")"
        print "%15s\t%6s\t%5s\t%20s\t%20s\t%10s\t%18s\n",a1[i,"pci"],a1[i,"name"],a1[i,"bond"],a1[i,"mac"],a1[i,"pmac"],state,a1[i,"ip"]
    }
    print "____________________________________________________________"
    print "Press Enter to Exit!"
    exit
    
}
{print "Done"; exit 0}
END {}

