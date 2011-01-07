import "adduser.pp"

class anjuke::adduser::sa inherits anjuke::adduser
{
    add_user
    {
        "demo":
        useruid     => 2000,
        username    => demo,
        userhome    => "demo",
        groups      => $operatingsystem ? {
		Ubuntu	=> ["admin"],
		CentOS	=> ["wheel"],
		RedHat	=> ["wheel"],
		default	=> ["wheel"],
	},
}

