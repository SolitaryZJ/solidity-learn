

### 部署与使用要点
1. 构造函数参数  
   - `_router`：UniswapV2 路由器地址（主网 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D）  
   - `_marketing`：用于接收税费的营销/运营钱包

2. 初始步骤  
   - 调用 `setIsTaxExempt(uniswapV2Pair, true)` 给池子免税  
   -  owner 把代币与 ETH 按 50/50 价值比例打入合约，再执行 `addLiquidityETH` 一键加池

3. 交易限制即时生效  
   - 单笔 ≤ 2% 总供应  
   - 单地址 ≤ 2% 总供应  
   - 同一地址 30 秒内只能交易一次  
   - 白名单地址不受限制

4. 税率可后期通过 `setTaxRates` 下调（上限 15%），亦可完全关闭税收 (`setTaxEnabled(false)`) 以满足上所或社区投票需求。