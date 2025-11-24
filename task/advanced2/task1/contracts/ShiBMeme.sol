// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./interfaces/IUniswapV2Router02.sol";

/**
 * @title SHIB Style MEME
 * @author Oliver
 * @notice SHIB Stylle MEME contract
 *          1. Tranaction tax: buy 3% | sell 9% -> 1/3 burn, 2/3 go to market
 *          2. Liquidity interact: add/removeLiquidity (integrate with UniswapV2Router)
 *          3. Tranaction Limit: one tx <= 2% total | one addresss <= 2% total | cool down duration 30s
 */
contract ShiBMeme is ERC20, Ownable{
    using SafeMath for uint256;
    /** 常量 */
    uint256 public constant TOTAL_SUPPLY = 1_000_000_000_000 * 10**18; // 1 trillion
    uint256 public constant MAX_TX_RATE = 200; // 2%
    uint256 public constant MAX_WALLET_RATE = 200; // 2%
    uint256 public constant COOL_DOWN_DURATION = 30 seconds; // 30s
    uint256 public constant TAX_BASIS = 10000; // 100%
    
    /** 税率 */
    uint256 public buyTax = 300; // 3%
    uint256 public sellTax = 900; // 9%
    address public marketingWallet; // 税务回流地址

    /** 交易限制 */
    bool public limitsInEffect = true; // 交易限制开关   
    bool public taxEnabled = true; // 税务开关
    mapping(address => bool) private isTaxExempt; // 交易限制白名单
    mapping(address => uint256) private lastTradeTime; // 冷却记录


    /** Uniswap */
    address public uniswapV2Pair; // Uniswap V2 交易对地址  
    IUniswapV2Router02 public uniswapV2Router; // Uniswap V2 路由地址

    /** 构造 */
    constructor(address _marketingWallet, address _uniswapV2Router) ERC20("SHIB Style MEME", "SHIBMEME") {
        require(_marketingWallet != address(0), "Marketing wallet cannot be zero address");
        require(_uniswapV2Router != address(0), "UniswapV2Router cannot be zero address");

        marketingWallet = _marketingWallet;
        uniswapV2Router = IUniswapV2Router02(_uniswapV2Router);

        // 创建 Uniswap V2 交易对
        uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory())
            .createPair(address(this), uniswapV2Router.WETH());

        // 免税白名单
        isTaxExempt[owner()] = true;
        isTaxExempt[address(this)] = true;
        isTaxExempt[marketingWallet] = true;

        // 铸造总量
        _mint(msg.sender, TOTAL_SUPPLY);
    }

    /** 核心转账 */
    function _transfer(address sender, address recipient, uint256 amount) internal override{
        // 1.交易限制
        if (limitsInEffect && !isTaxExempt[sender] && !isTaxExempt[recipient]) {
            require(amount <= maxTxAmount(), "Transfer amount exceeds the maxTxAmount.");
            if (sender != uniswapV2Pair && recipient != uniswapV2Pair) {
                require(balanceOf(recipient).add(amount) <= maxWalletAmount(), "Recipient exceeds max wallet amount.");
            }
            if (lastTradeTime[sender] != 0) {
                require(block.timestamp.sub(lastTradeTime[sender]) >= COOL_DOWN_DURATION, "Sender is in cool down period.");
            }
            lastTradeTime[sender] = block.timestamp;
        }

        // 2.计算税费
        uint256 taxAmount = 0;
        if (taxEnabled && !isTaxExempt[sender] && !isTaxExempt[recipient]) {
            if (recipient == uniswapV2Pair) { // 卖出
                taxAmount = amount.mul(sellTax).div(TAX_BASIS);
            } else if (sender == uniswapV2Pair) { // 买入
                taxAmount = amount.mul(buyTax).div(TAX_BASIS);
            }
        }

        // 3.税务分配
        uint256 burnAmount = taxAmount.div(3); // 1/3 燃烧
        uint256 marketingAmount = taxAmount.sub(burnAmount); // 2/3 市场
        if (burnAmount > 0) {
            _burn(address(this), burnAmount);
        }
        if (marketingAmount > 0) {
            super._transfer(sender, marketingWallet, marketingAmount); // 市场
        }

        // 4.执行转账
        super._transfer(sender, recipient, amount.sub(taxAmount));
    }    

    /** 流动性交互 */
    function addLiquidityETH(uint256 tokenAmount, uint256 ethAmountMin) external onlyOwner payable{
        _approve(address(this), address(uniswapV2Router), tokenAmount);
        uniswapV2Router.addLiquidityETH{value: msg.value}(
            address(this),
            tokenAmount,
            0,
            ethAmountMin,
            owner(),
            block.timestamp
        );
    }

    fucntion removeLiquidityETH(uint256 liquidity, uint256 tokenAmountMin, uint256 ethAmountMin) external onlyOwner{
        IERC20(uniswapV2Pair).approve(address(uniswapV2Router), liquidity);
        uniswapV2Router.removeLiquidityETH(
            address(this),
            liquidity,
            tokenAmountMin,
            ethAmountMin,
            owner(),
            block.timestamp
        );
    }


    /** 管理功能 */
    function setTxRates(uint256 _buyTax, uint256 _sellTax) external onlyOwner{
        require(_buyTax <= 1500, "Buy tax cannot exceed 15%");
        require(_sellTax <= 1500, "Sell tax cannot exceed 15%");
        buyTax = _buyTax;
        sellTax = _sellTax;
    }

    function setMarketingWallet(address _marketingWallet) external onlyOwner{
        require(_marketingWallet != address(0), "Marketing wallet cannot be zero address");
        marketingWallet = _marketingWallet;
    }
    function setLimitsInEffect(bool _limitsInEffect) external onlyOwner{
        limitsInEffect = _limitsInEffect;
    }
    function setTaxEnabled(bool _taxEnabled) external onlyOwner{
        taxEnabled = _taxEnabled;
    }
    function setIsTaxExempt(address account, bool exempt) external onlyOwner{
        isTaxExempt[account] = exempt;
    }

    /** other method */
    function maxTxAmount() public view returns(uint256){
        return TOTAL_SUPPLY.mul(MAX_TX_RATE).div(TAX_BASIS);
    }

    function maxWalletAmount() public view returns(uint256){
        return TOTAL_SUPPLY.mul(MAX_WALLET_RATE).div(TAX_BASIS);
    }

    receive() external payable {}
}