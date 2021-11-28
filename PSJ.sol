pragma solidity ^0.4.11;

contract PSJ_ico{
    //Total coin available
    uint public max_PSJ=10000000;
    //coversion usd to PSJ_ico
    uint public usd_to_PSJ=1000;
    //total bought
    uint public total_PSJ_bought=0;
    
    //mapping betwwen address and bought
    mapping(address => uint) equity_PSJ;
    mapping(address => uint) usd_PSJ;
    
    //Checking if invester buy PSJ_ico
    modifier can_buy_PSJ(uint usd_invested){
        require(usd_invested*usd_to_PSJ + total_PSJ_bought <= max_PSJ);
        _;
    }
    function equity_in_PSJ(address invester) external constant returns (uint){
        return equity_PSJ[invester];
    }
    function equity_in_usd(address invester) external constant returns (uint){
        return usd_PSJ[invester];
    }
    //buy PSJ
    function buy_PSJ(address invester, uint usd_invested) external 
    can_buy_PSJ(usd_invested){
       uint PSJ_bought = usd_invested * usd_to_PSJ;
        equity_PSJ[invester] += PSJ_bought;
        usd_PSJ[invester] = equity_PSJ[invester]/1000;
        total_PSJ_bought += PSJ_bought;
    }
    //selling PSJ_bought
    function sell_PSJ(address invester, uint PSJ_sold) external {
        equity_PSJ[invester] -= PSJ_sold;
        usd_PSJ[invester] = equity_PSJ[invester]/1000;
        total_PSJ_bought -= PSJ_sold;
    }
}