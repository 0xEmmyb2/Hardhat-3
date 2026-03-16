//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;
import "./Ownable.sol";
import "./Pausable.sol";


contract ProductStore is Ownable, Pausable {
    struct Product {
        string name;
        uint price;
        bool isAvailable;
    }

    mapping(uint => Product) public products;
    uint public totalProducts;
    
    event ProductAdded(uint indexed productId, string name, uint price);
    event AvailabilityChanged(uint indexed productId, bool isAvailable);


    modifier productExists(uint productId) {
        require(productId < totalProducts, "Product does not exist");
        _;
    }

    

    function addProduct(string memory _name, uint _price) public onlyOwner whenNotPaused { {
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

    function getProduct(uint productId) public view productExists(productId) returns (string memory, uint, bool) {
        Product memory product = products[productId];
        return (product.name, product.price, product.isAvailable);
    }

    function toggleAvailability(uint productId) public onlyOwner notPaused productExists(productId) {
        products[productId].isAvailable = !products[productId].isAvailable;
        emit AvailabilityChanged(productId, products[productId].isAvailable);
    }

    function deleteProduct(uint productId) public onlyOwner notPaused productExists(productId){
        require(product[productId].isAvailable, "Product does not exist");
        delete products[productId];
    }
}