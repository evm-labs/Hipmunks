pragma solidity ^0.8.13;
// SPDX-License-Identifier: None

/*
             ,;:;;,
           ;;;;;
   .=',    ;:;;:,    ░░░░░    Ｈｉｐｐｉｅ   ░░░░░
  /_', "=. ';:;:;    ░░░░░   Ｈｉｐｓｔｅｒ   ░░░░░ 
  @=:__,  \,;:;:'    ░░░░░  Ｃｈｉｐｍｕｎｋｓ ░░░░░
    _(\.=  ;:;;'
   `"_(  _/="`
   `"'``
                    𝕓𝕪 @𝕖𝕧𝕞_𝕝𝕒𝕓𝕤 & @𝕕𝕚𝕞𝕚𝕣𝕖𝕒𝕕𝕤𝕥𝕙𝕚𝕟𝕘𝕤 (𝕋𝕨𝕚𝕥𝕥𝕖𝕣)
*/

contract Hipnation{

    mapping(string => address payable) internal Charities;
    string [] CharitiesArray = ["UNICEF", "UKRAINE"];

    constructor(){

        Charities["UNICEF"] = payable(address(0));
        Charities["UKRAINE"] = payable(address(0));
    }

/*
1. Mapping of 20 address (string -> address)
2. Lock 15% of made to only be able to be withdrawn by one of these addresses
3. Unlocks every 4th Friday for 2 days for admins to only be able to send to charity
4. Admins can only send to one of these addresses

*/
}