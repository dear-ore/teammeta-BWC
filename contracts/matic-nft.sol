//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import { Base64 } from "./libraries/Base64.sol";

contract NFTLottery is ERC721URIStorage {

    //using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private tokenIds;
    constructor() ERC721("TEAMMATIC", "MATIC") {} 

    string[] firstwords = ["Bread", "cheese", "basil", "rice", "spaghetti", "noodles", "beans", "pizza", "icecream", "chicken", "nuggets", "potatoes", "prawn", "turkey", "burger", "hotdog", "syrup", "waffles", "pancakes", "crepes"];
    string[] secondwords = ["dance", "swim", "cook", "jump", "make", "cry", "smile", "laugh", "sick", "important", "worried", "love", "busy", "school", "electrons", "photons", "maple", "candles", "cane", "grow"];
    string[] thirdwords = ["goat", "lion", "tiger", "tortoise", "spider", "bat", "cat", "dog", "alligator", "crocodile", "squirrel", "slug", "snail", "koala", "bear", "bison", "giraffe", "dear", "elephant", "horse"];
    
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: pink; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    function makeFirstWord(uint tokenId) public view returns(string memory) {
        uint rand = uint(keccak256(abi.encodePacked("FIRSTwords", Strings.toString(tokenId))));
        rand = rand%firstwords.length;
        return firstwords[rand];
    }
    
    function makeSecondWord(uint tokenId) public view returns(string memory) {
        uint rand = uint(keccak256(abi.encodePacked("SECONDwords", Strings.toString(tokenId))));
        rand = rand%secondwords.length;
        return secondwords[rand];
    }

    function makeThirdWord(uint tokenId) public view returns(string memory) {
        uint rand = uint(keccak256(abi.encodePacked("THIRDwords", Strings.toString(tokenId))));
        rand = rand%thirdwords.length;
        return thirdwords[rand];
    }
    
    function mintAnNFT() public {
        uint256 newItemID = tokenIds.current();

        string memory first = makeFirstWord(newItemID);
        string memory second = makeSecondWord(newItemID);
        string memory third = makeThirdWord(newItemID);
        string memory combinedWord = string(abi.encodePacked(first, second, third));

        string memory finalSvg = string(abi.encodePacked(baseSvg,first,second,third, "</text></svg>"));

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "', 
                          combinedWord,
                          '", "description": "Team Matic NFT lottery collection", "image" : "data:image/svg+xml;base64,',
                          Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        _safeMint(msg.sender, newItemID);
        _setTokenURI(newItemID, finalTokenUri);
        tokenIds.increment();
    }

    // function tokenURI(uint _tokenId) public view override returns(string memory) {
    //     require(_exists(_tokenId));
    //     return string(
    //         abi.encodePacked(
    //             "data: application/json;base64,"
    //         )
    //     );
    // }
}


//0x1E839371A732B639F450A2C03445D0F6F4F35631
//0x344DDddc3E8560b5697Ce4168b53869EFE520980 - celo testnet contract address