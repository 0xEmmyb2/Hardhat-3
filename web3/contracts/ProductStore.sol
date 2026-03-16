//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";


//Custom Errors
error InvalidName();
error InvalidPrice();
error ProductNotFound(uint productId);


contract ProductStore is Ownable, Pausable, ReentrancyGuard {
    struct Product {
        string name;
        uint price;
        bool isAvailable;
    }

    mapping(uint => Product) public products;
    uint public totalProducts;
    
    event ProductAdded(uint indexed productId, string name, uint price);
    event AvailabilityChanged(uint indexed productId, bool isAvailable);
    event ProductDeleted(uint indexed productId);


    constructor() Ownable(msg.sender) {}


    modifier productExists(uint productId) {
       if(productId >= totalProducts || bytes(products[productId].name).length == 0) revert ProductNotFound(productId);
        _;
    }

    

    function addProduct(string memory _name, uint _price) public onlyOwner whenNotPaused nonReentrant {
        if(bytes(_name).length == 0) revert InvalidName();
        if(_price == 0) revert InvalidPrice();

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

    function toggleAvailability(uint productId) public onlyOwner whenNotPaused productExists(productId) {
        products[productId].isAvailable = !products[productId].isAvailable;
        emit AvailabilityChanged(productId, products[productId].isAvailable);
    }

    function deleteProduct(uint productId) public onlyOwner whenNotPaused productExists(productId){
        delete products[productId];
         emit ProductDeleted(productId);
    }

    function pauseStore() public onlyOwner {
        _pause();
    }

    function unpauseStore() public onlyOwner{
        _unpause();
    }
}