contract owned {
        function owned() { owner = msg.sender; }
        address owner;

        modifier onlyowner { if (msg.sender == owner) _ }
}

contract mortal is owned {
        function kill() onlyowner {
                suicide(owner);
        }
}


contract MembershipRoster is mortal {
        address[] members;
        uint currentIndex;
        uint memberCount;

        mapping (address => bool) isMember;
        mapping (address => uint) memberIndex;

        modifier onlymember { if (isMember[msg.sender] == true) _ }

        function MembershipRoster(address creator) {
            addMember(msg.sender);
            addMember(creator);
        }

        function addMember(address memberAddress) onlymember returns (bool successful) {
                if ( isMember[memberAddress] ) {
                        return false;
                }

                isMember[memberAddress] = true;
                members[currentIndex] = memberAddress;
                memberCount++;
                currentIndex++;

                return true;
        }

        function removeMember(address memberAddress) onlymember returns (bool successful) {
                if ( !isMember[memberAddress] ) {
                        return false;
                }
                isMember[memberAddress] = false;
                members[memberIndex[memberAddress]] = 0x0;

                memberCount--;

                return true;
        }
}


contract EthereumPublicTrust is mortal {
        address membershipRoster;

        // Initializer
        function EthereumPublicTrust() {
                membershipRoster = address(new MembershipRoster(msg.sender));
        }
}
