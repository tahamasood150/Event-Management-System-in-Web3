// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract EventManager{

    struct Event {
        address _oraganizer;
        string EventName;
        uint price;
        uint EventDate;
        uint EventTotalTicket;
        uint EventTicketLeft;

    }
// struck bracket close

mapping(uint=>Event) public events;

uint256 public nextID; //1354538

function CreateYourEvent(string memory EventName,uint price,uint EventDate,uint EventTotalTicket)external {
        require(EventDate>block.timestamp,"You are creating Event for that date which is past . Please Enter Suitable Date ");
        require(EventTotalTicket>0,"Event Total Ticket is should be greater than 0");
        events[nextID] = Event(msg.sender,EventName,price,EventDate,EventTotalTicket,EventTotalTicket);
        nextID++;
}

mapping(address=>mapping(uint=>uint)) public tickets;

function BuyTickets(uint id,uint quantity) external payable {
    require(events[id].EventDate!=0,"Event does not exist");
    require(events[id].EventDate>block.timestamp,"Event is already occured");
    Event storage _event = events[id];
    require(msg.value==(_event.price*quantity),"Ether you have transferred is not sufficient");
    require(_event.EventTicketLeft>=quantity,"Not enough Ticket");
    _event.EventTicketLeft-=quantity;
    tickets[msg.sender][id]+=quantity;

}

function TransferTicket(uint id,uint quantity,address Transfer_to) external {
    require(events[id].EventDate!=0,"Event does not exist");
    require(events[id].EventDate>block.timestamp,"Event is already occured");
    require(tickets[msg.sender][id]>=quantity,"You don't have sufficient tickets");
    tickets[msg.sender][id]-=quantity;
    tickets[Transfer_to][id]+=quantity;

}

// Below Death
}