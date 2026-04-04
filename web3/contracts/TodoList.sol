//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";


struct Todo {
    string title;
    bool isCompleted;
    uint id;
}

//Custom Errors Handling
error TodoNotFound(uint id);
error Unauthorized();
error InvalidTitle();
error TodoAlreadyCompleted(uint id);





contract TodoList is Ownable,ITodoList,Pausable {
    Todo[] public todos;
    mapping(uint => Todo) public todoById;

    constructor() Ownable(msg.sender) {}

    modifier todoExists(uint _id) {
        if(_id >= todos.length) revert TodoNotFound(_id);
        _;
    }
    

    //Adding Todos to the list
    function addTodo(string memory _title) external onlyOwner whenNotPaused {
        if(bytes(_title).length == 0) revert InvalidTitle();
        uint id = todos.length;
        Todo memory newTodo = Todo({
            title: _title,
            isCompleted: false,
            id: id
        });
        todos.push(newTodo);
        todoById[id] = newTodo;
        emit TodoAdded(id, _title);
    }
    

    //Marking the todo as completed
    function completeTodo(uint _id) external onlyOwner whenNotPaused todoExists(_id) {
        if(todos[_id].isCompleted) revert TodoAlreadyCompleted(_id);
        todos[_id].isCompleted = !todos[_id].isCompleted;
        todoById[_id].isCompleted = !todoById[_id].isCompleted;
        emit TodoCompleted(_id);
    }


    function getAllTodos() external view returns(Todo[] memory) {
        return todos;
    }

    function getTodoById(uint _id) external view todoExists(_id) returns(uint, string memory, bool) {
        Todo memory todo = todoById[_id];
        return (todo.id, todo.title, todo.isCompleted);
    }

    function getTotalTodos() external view returns(uint) {
        return todos.length;
    }
}