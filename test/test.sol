// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract StorageModesLearning {
    // 1. storage 永久性存储
    // 2. memory 暂时性存储 运行时可被修改
    // 3. calldata 暂时性存储 运行时不可被修改
    // 4. stack
    // 5. codes
    // 6. logs
    function test(
        string memory testStr,
        string calldata testStr2
    ) public pure returns (string calldata) {
        testStr = "2312312";
        // 以下代码会编译错误
        // testStr2 = "dsadsa";
        return testStr2;
    }
}

contract HelloWorld {
    // 声明结构体
    struct Info {
        uint256 id;
        string desc;
        address addr;
    }

    string myName = "motherfucker";

    //          within contract | outside contract  | child contract | external account
    // public       ✅          ｜        ✅         |      ✅        |         ✅
    // external     ❌          ｜        ✅         |      ❌        |         ✅
    // internal     ✅          ｜        ❌         |      ✅        |         ❌
    // private      ✅          ｜        ❌         |      ❌        |         ❌
    // view: 表明这个函数内部不对任何数据做赋值操作，而只是读
    function sayMyName() public view returns (string memory) {
        return addInfo(myName);
    }
    function setMyName(string memory newName) public {
        myName = newName;
    }
    // pure: 表明不做读取，只做单纯运算
    // string.concat 做字符串拼接
    function addInfo(
        string memory infoStr
    ) private pure returns (string memory) {
        return string.concat(infoStr, " from FunctionLearning contract");
    }
}

contract ComplexTypeLearning {
    struct MyConfig {
        uint256 id;
        uint256 count;
        string desc;
        address addr;
    }

    MyConfig[] configs;

    HelloWorld[] hws;

    mapping(uint256 id => MyConfig info) myConfigMap;

    function addArrConfig(
        uint256 id,
        uint256 count,
        string calldata desc
    ) public {
        MyConfig memory config = MyConfig(id, count, desc, msg.sender);
        configs.push(config);
    }

    function getArrConfig(uint256 _id) public view returns (MyConfig memory) {
        if (configs.length == 0) {
            revert("Config not found.");
        }
        for (uint256 i = 0; i < configs.length; i++) {
            if (configs[i].id == _id) {
                return configs[i];
            }
        }
        revert("Config not found.");
    }

    function addMapConfig(
        uint256 id,
        uint256 count,
        string calldata desc
    ) public {
        MyConfig memory config = MyConfig(id, count, desc, msg.sender);
        myConfigMap[id] = config;
    }

    function getMapConfig(uint256 _id) public view returns (MyConfig memory) {
        return myConfigMap[_id];
    }

    function addHelloWorld() public {
        hws.push(new HelloWorld());
    }

    function sayHelloWorld(uint256 _idx) public view returns (string memory) {
        return hws[_idx].sayMyName();
    }
}
