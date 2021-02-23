:do {
  :local newtvs 0;
  :local debug "no";
  :local foundtv "no";
  :local push "http://172.16.8.100:5000/push_notif"

  :foreach leasecounter in=[/ip dhcp-server lease find where dynamic] do={
    :local leasename [/ip dhcp-server lease get $leasecounter host-name];
    :local leaseip [/ip dhcp-server lease get $leasecounter address];
    :local leasemac [/ip dhcp-server lease get $leasecounter mac-address];
    :local new "host=$leasename&ip=$leaseip&mac=$leasemac"
    :log warning "!!! NEW LEASE: $leasename using $leaseip $leasemac END !!!";
    /tool fetch url=$push  http-method=post output=none http-data=$new
  };
};