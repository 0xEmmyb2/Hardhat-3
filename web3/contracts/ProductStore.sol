//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;


contract ProductStore {
    struct Product {
        string name;
        uint price;
        bool isAvailable;
    }

    address public owner;
    mapping(uint => Product) public products;
    uint public totalProducts;
    
    event ProductAdded(uint indexed productId, string name, uint price);
    event AvailabilityChanged(uint indexed productId, bool isAvailable);

    constructor() {
        owner = msg.sender;
    }

    function addProduct(string memory _name, uint _price) public {
        require(msg.sender == owner, "Only owner can add products");
        require(bytes(_name).length > 0, "Product name cannot be empty");
        require(_price > 0, "Price must be greater than zero");

        products[totalProducts] = Product({
            name: _name,
            price: _price,
            isAvailable: true
        });
        
        emit ProductAdded(totalProducts, _name, _price);
        totalProducts++;
    }

    function getProduct(uint productId) public view returns (string memory, uint, bool) {
        require(productId < totalProducts, "Product does not exist");
        Product memory product = products[productId];
        return (product.name, product.price, product.isAvailable);
    }

    function toggleAvailability(uint productId) public {
        require(msg.sender == owner, "Only owner can change availability");
        require(productId < totalProducts, "Product does not exist");
        products[productId].isAvailable = !products[productId].isAvailable;
        emit AvailabilityChanged(productId, products[productId].isAvailable);
    }
}