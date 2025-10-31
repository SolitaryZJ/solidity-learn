1. require / assert / revert 的区别是什么
   - assert(bool condition)：检查内部错误或逻辑错误。如果断言失败，状态将回滚，并消耗所有剩余的 Gas。
   - require(bool condition)：用于检查外部输入或调用条件。如果条件不满足，状态回滚，并返还剩余的 Gas。
   - revert()：立即终止交易并回滚状态
2. modifier的作用<br/>
   函数修改器用于改变函数的行为，可以用于验证条件、修改参数等。

3. storage/memory/calldata 相关的存储位置的使用区别<br/>
- storage：存储在区块链上，存储的数据永久保存，存储的数据会永久保存在区块链。消耗gas最多
- memory：存储在堆上，存储的数据会临时保存。
- calldata：外部调用的参数，调用结束后数据会自动删除。gas最少
4. 写一个最简单的 ERC20 代币合约（mint + transfer）<br/>
   https://github.com/SolitaryZJ/solidity-learn/blob/main/task/task2/MyERC20.sol