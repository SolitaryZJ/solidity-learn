// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CombineTwoSortedArray{

    // function merge(uint[] memory _array1, uint[] memory _array2) public pure returns(uint[] memory){
    //     uint p1 = _array1.length - 1;
    //     uint p2 = _array2.length - 1;
    //     uint p = _array1.length + _array2.length - 1;
    //     for (; p2 >= 0;) {
    //         if (p1 >=0 && _array1[p1]>_array2[p2]) {
    //             _array1[p--]=_array2[p1--];
    //         } else {
    //             _array1[p--]=_array2[p2--];
    //         }
    //     }
    //     return _array1;
    // }
function mergeSortedArray(
        int256[] memory a,
        int256[] memory b
    ) external pure returns (int256[] memory) {
        uint256 m = a.length;
        uint256 n = b.length;
        // 新建一个长度 m+n 的数组，前 m 位拷 a，后 n 位 0
        int256[] memory merged = new int256[](m + n);
        for (uint256 i; i < m; ++i) merged[i] = a[i];
        // 原地合并
        merge(merged, m, b, n);
        return merged;
    }
    function merge(
        int256[] memory nums1,
        uint256 m,
        int256[] memory nums2,
        uint256 n
    ) internal pure {
        // 采用尾插法，从大到小放，避免覆盖
        uint256 i = m;        // nums1 末尾有效元素后一位
        uint256 j = n;        // nums2 末尾后一位
        uint256 k = m + n;    // 合并后末尾后一位

        while (k > 0) {
            --k;
            if (j == 0) {                          // nums2 已取完
                nums1[k] = nums1[--i];
            } else if (i == 0) {                   // nums1 已取完
                nums1[k] = nums2[--j];
            } else if (nums1[i - 1] > nums2[j - 1]) {// 取较大者
                nums1[k] = nums1[--i];
            } else {
                nums1[k] = nums2[--j];
            }
        }
    }
}