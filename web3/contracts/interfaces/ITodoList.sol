//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


//The interfaces of our contract 
interface ITodoList {
    event TodoAdded(uint indexed id, string title);
    event TodoCompleted(uint indexed id);

    function addTodo(string memory _title) external;
    function completeTodo(uint _id) external;
    function getAllTodos() external view returns(Todo[] memory);
    function getTodoById(uint _id) external view returns(uint, string memory, bool);
    function getTotalTodos() external view returns(uint);
}