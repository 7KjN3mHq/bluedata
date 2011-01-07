class anjuke::resolv
{
        $searchpath = "puppet.com"
        $nameservers = ["8.8.8.8"]
        file { "resolv.conf":
                name => "/etc/resolv.conf",
                content => template("base/resolv-template.erb")
        }
}
