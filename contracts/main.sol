contract owned {
        function owned() { owner = msg.sender; }
        address owner;

        modifier onlyowner { if (msg.sender == owner) _ }

        function kill() onlyowner {
                suicide(owner);
        }
}


contract EthereumPublicTrust {
        address membershipRoster;
        address balletBox;

        // Initializer
        function EthereumPublicTrust() {
                membershipRoster = address(new MembershipRoster());
                balletBox = address(new BalletBox());
        }


        function checkMembership( {
        }
}


contract MembershipRoster is owned {
        address creator;

        address[] members;
        uint memberCount;

        mapping (address => bool) isMember;

        function MembershipRoster(address creator) {
                creator = creator;
                members[0] = creator;
                memberCount++;
                isMember[creator] = true;
        }

        function addMember(address newMember) onlyowner {
                if ( isMember[newMember] ) {
                        return false;
                }

                members[0] = newMember;
                memberCount++;
                isMember[newMember] = true;

                return true;
        }

        function removeMember() ownlyowner {
        }
}


contract BalletBox is owned {
        modifier onlymember { if (owner.call("checkMembership", msg.sender) _ }

        function createVote() onlymember {
        }
}


contract vote {
        address balletBox;

        modifier onlyballetbox { if (msg.sender == balletBox) _ }

        function vote(address balletBox) {
                balletBox = balletBox;
        }

        function ratify() onlyballetbox;

        function fail() onlyballetbox {
                suicide(balletBox);
        }

        function check() {
                if ( msg.sender != balletBox ) {
                        __throw();
                }
        }
}
