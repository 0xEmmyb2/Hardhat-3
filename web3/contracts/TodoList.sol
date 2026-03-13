//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "./Ownable.sol";
import "./Pausable.sol";


contract TodoList is Ownable, Pausable {
    struct Todo {
        string title;
        bool isCompleted;
        uint id;
    }


    Todo[] public todos;
    mapping(uint => Todo) public todoById;

    event TodoAdded(uint indexed id, string title);
    event TodoCompleted(uint indexed id);

    

    modifier todoExists(uint _id) {
        require(_id < todos.length, "Todo does not exist");
        _;
    }

    function addTodo(string memory _title) public onlyOwner notPaused {
        require(bytes(_title).length > 0, "Title cannot be empty");
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

    function completeTodo(uint _id) public onlyOwner todoExists(_id) {
        require(!todoById[_id].isCompleted, "Todo is already completed");
        todos[_id].isCompleted = !todos[_id].isCompleted;
        todoById[_id].isCompleted = !todoById[_id].isCompleted;
        emit TodoCompleted(_id);
    }


    function getAllTodos() public view returns(Todo[] memory) {
        return todos;
    }

    function getTodoById(uint _id) public view todoExists(_id) returns(uint, string memory, bool) {
        Todo memory todo = todoById[_id];
        return (todo.id, todo.title, todo.isCompleted);
    }

    function getTotalTodos() public view returns(uint) {
        return todos.length;
    }
}