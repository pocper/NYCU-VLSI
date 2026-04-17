# NYCU-VLSI
## 簡介
- **學校** : 國立陽明交通大學
- **開課單位** : 電控碩
- **課程名稱** : 超大型積體電路系統設計
- **授課教授** : 黃聖傑 副教授
- **修課時間** : 2023年09月~2023年12月
- **最終成績** : A+

## Lab內容
1. Lab01 - Simple Logic Design
   - 建立邏輯閘及其測試資料 (Testbench)
     - 實作反向器 (Inverter)、二輸入及閘 (AND2) 與二輸入反及閘 (NAND2)
     - 電源供應 : 1.8V
     - 上升/下降時間 : 1ns
     - 週期: 20us
   - (Bonus) 兩級式運算放大器設計 (Two-stage OP AMP Design)
     - 負載電容 (CL) = 4 pF, 增益 (Av) > 4000
     - 增益頻寬積 (GB) = 2 MHz
     - 共模範圍 (CMR): 1 < CMR < 4, 輸出擺幅 (Vout)： 0.8 < Vout < 4.2
     - 壓擺率 (SR) = 2V/us, 功耗 (Pdiss) < 10 mW

2. Lab02 - Multiplier-Accumulator(MAC)
   - 多項式運算：應用 霍納演算法 (Horner's Method)，透過迭代執行 MAC 運算來求解多項式 $f(x) = x^3 + 2x^2 + x + 1$

3. Lab03 - Arithmetic Logic Unit(ALU)
   - 多功能 ALU 設計與實作
     - 驗證任務：學號運算測試。利用個人學號進行連續的「先乘後加」運算，以驗證 ALU 的功能正確性
   - (Bonus) 跨時鐘域輸入處理
     - 設計目標：實作跨時域的同步策略，確保 ALU 能處理來自不同且非同步時鐘域的輸入資料，避免資料亞穩態 (Metastability) 問題

4. Midterm #1 - Quantum Full Adder
   - 題目敘述
     - 核心實作：利用 Verilog 定義量子運算中的基本邏輯單元，包含 CNOT Gate (control_not2) 與 Toffoli Gate (control_not3) 模組
     - 電路整合：參照量子線路圖（Quantum Circuit Diagram），將上述可逆邏輯閘進行級聯（Cascading），建構出具備資訊不遺失特性的 Quantum Full Adder 系統
     - 模擬驗證：建立模擬測試平台（Testbench），透過操作控制位元（Control Bits）驗證該線路在特定初始值下，能正確輸出全加器的 加總 (Sum) 與 進位 (Carry) 結果
   - 量子線路圖
        ```
        (Input)                                     (Output)
        a ---------o---------o--------------------------- a' = a
                   |         |
        b ---------o---------|---------o---------o------- b' = b
                   |         |         |         |
        c ---------|---------o---------o---------|------- SUM = a ^ b ^ c
                   |         |         |         |
        d=0 -------X---------X---------|---------X------- CARRY = (a&b)     ^ (c&(a^b))
              (Toffoli)  (Toffoli)   (CNOT)    (CNOT)
        ```
   - 說明
     - o 與 |：代表控制點（Control nodes），對應你程式碼中的 a 或 a & b 判斷
     - X：代表反轉點（Target nodes / NOT operation），對應 ~b 或 ~c 的邏輯
   - 資料路徑
     - 第一個與第二個 X 是 Toffoli Gates（對應control_not3）
     - 後續的 X 是 CNOT Gates（對應control_not2）
     - 最終在 $c$ 路徑輸出 SUM，在 $d$ 路徑輸出 CARRY

5. Lab04 - 繪製不同類型的inverter
   - Layout 設計：完成 One-Stick、Folded 與 Two-Stick 三種反向器
   - 驗證流程：每個設計均完成 Schematic、DRC、LVS 及 Post-layout 模擬

6. Lab05 - 繪製記憶體
   - Layout 設計：完成D型鎖存器(D-type Latch)
   - (Bonus) 完成靜態隨機存取記憶體(Static Random-Access Memory) - 6T SRAM
   - 驗證流程：每個設計均完成 Schematic、DRC、LVS 及 Post-layout 模擬

7. Lab06 - 繪製放大器
   - Layout 設計：兩級式運算放大器設計
   - 驗證流程：每個設計均完成 Schematic、DRC、LVS 及 Post-layout 模擬

8. Midterm #2 - Layout
   - Level Shifter
     - 設計目標：實現低壓域 (vdd) 與高壓域 (vddHV) 之間的邏輯信號轉換
     - 架構說明：
       - 輸入級：由低壓反相器 (Low Voltage Inverter) 產生差分信號
       - 轉換級：利用 Cross-coupled PMOS 結構達成電位提升，確保在高壓域下邏輯切換穩定
       - 輸出級：透過 Buffer 增加驅動實力
     - 電路拓樸：
        ```
        (vdd)             (vddHV)               (vddHV)
               |               |     |                  |
             --+--           --+-- --+--              --+--
             | P1|           | P2| | P3|              | P4|
        IN --|   |       [A]-|   | |   |-[B]      [B]-|   |--- OUT
             --+--           --+-- --+--              --+--
               |               |     |                  |
               +---(~IN)       |     |                  o---[B]
               |               |     |                  |
             --+--           --+-- --+--              --+--
             | N1|           | N2| | N3|              | N4|
        IN --|   |       (IN)-|   | |   |-(~IN)   [B]-|   |
             --+--           --+-- --+--              --+--
               |               |     |                  |
              GND             [B]   [A]                GND
        
         [ 1. Inverter ]   [ 2. LS Core ]     [ 3. Buffer ]
        ```
    - (Bonus) Ampli Diff
      - 設計目標：實現一個能放大兩個輸入端點電壓差值（$V_p - V_m$），同時抑制共模雜訊（Common-mode rejection）的類比電路
      - 架構說明：輸入級 (Differential Pair)：由一對特性匹配的 NMOS（N1, N2）組成，負責接收差動輸入訊號並轉化為電流變化
        - 主動負載 (Active Load)：利用 電流鏡 (Current Mirror) 結構（P1, P2）取代傳統電阻，以獲得極高的輸出阻抗與電壓增益
        - 尾電流源 (Tail Current Source)：底部由 $V_{bias}$ 控制的 NMOS（N3），提供穩定的總工作電流，決定了電路的靜態功耗與線性範圍
      - 電路拓樸：
        ```
                 (VDD)               (VDD)
                   |                   |
                ---+---             ---+---
                | P1  |             | P2  |
          [G1]--|     |       [G1]--|     |
                ---+---             ---+---
                   |                   |
             [G1]--o----[D1]           o---- Vout
                         |             |
                      ---+---       ---+---
                      | N1  |       | N2  |
                Vp ---|     |       |     |--- Vm
                      ---+---       ---+---
                         |             |
                         +------o------+
                                |
                             ---+---
                             | N3  |
                    Vbias ---|     |  (Tail Current)
                             ---+---
                                |
                               GND
        ```
9. Lab07 - System Chip Design
   - 環境建置與模組編譯：
     - 建置 Verilog 模擬環境，並完成 JPEG XR Decoder 各子模組的模擬
   - (Bonus) 系統整合與結果分析
     - 全系統整合：修正並銜接各模組之輸入輸出介面，完成 JPEG XR Decoder 完整資料路徑之整合
     - 系統功能驗證：運行全系統模擬並透過波形分析，確認解碼結果之正確性
     - 設計指標評估：針對整合後之設計，評估其最大運作頻率、功耗表現及晶片佔用面積

10. Lab08 - SoC TPU
    - AlphaGo SoC 設計流程推演
      - 模擬 AlphaGo 晶片專案負責人角色，從原始規格 (Spec) 出發，推導至晶片實作，詳細說明大尺度 SoC 的設計流程與架構決策
    - (Bonus) TPU 演進架構驗證
      - 以 Google TPU v2、v3、v4 為例，透過手工推導過程，驗證不同世代 TPU 架構在處理效能、記憶體頻寬與互連技術上的演進與改進

11. Lab09 - Bitcoin Miner
    - 程式來源：參考 [知乎專欄：比特幣挖礦與 SHA-256 硬體實作](https://zhuanlan.zhihu.com/p/550557623) 之程式架構
    - 環境建置：建立 Verilog 模擬環境，完成該組合邏輯展開式礦機核心之編譯
    - 功能驗證：透過 640-bit 區塊標頭輸入，驗證雙重 SHA-256 運算路徑與端序轉換之正確性

12. Final Project - Systolic Array
    - 程式來源：參考並引用自 [github - systolic_array_matrix_multiplier](https://github.com/debtanu09/systolic_array_matrix_multiplier) 之硬體描述語言架構
    - 設計目標：實現一個 $4 \times 4$ 的脈動陣列架構，用於執行高效能的矩陣乘法運算（包含 8 組 32-bit 輸入與 16 組輸出） 

## 編譯
1. Lab01 - Simple Logic Design
    ``` bash
    cd nycu-vlsi/01_lab01_logic_gate
    hspice -i ./and2/and2_tb.sp -o and2_result
    hspice -i ./not/not_tb.sp -o not_result
    hspice -i ./two-stage-opAmp/op_2stage_tb.sp -o op_2stage_result
    ```

2. Lab02 - Multiplier-Accumulator(MAC)
    ``` bash
    cd nycu-vlsi/02_lab02_mac
    iverilog -o MAC_sim.vvp MAC.v MAC_tb.v
    vvp MAC_sim.vvp
    # gtkwave MAC_sim.vcd
    ```

3. Lab03 - Arithmetic Logic Unit(ALU)
    ``` bash
    cd nycu-vlsi/03_lab03_datapath
    iverilog -o Lab3_sim.vvp ALU/ALU.v FIFO/FIFO.v Lab3_tb.v
    vvp Lab3_sim.vvp
    # gtkwave Lab3_sim.vcd
    ```
   - ALU 測試
        ``` bash
        cd nycu-vlsi/03_lab03_datapath/ALU
        iverilog -o ALU_sim.vvp ALU.v ALU_tb.v
        vvp ALU_sim.vvp
        # gtkwave ALU_sim.vcd
        ```
    - FIFO 測試
        ``` bash
        cd nycu-vlsi/03_lab03_datapath/FIFO
        iverilog -o FIFO_sim.vvp FIFO.v FIFO_tb.v
        vvp FIFO_sim.vvp
        # gtkwave FIFO_sim.vcd
        ```

4. Lab07 - System Chip Design
   ``` bash
    cd nycu-vlsi/lab07_system_chip_design/jpeg_decoder
    iverilog -g2012 -o jpeg_decoder_sim.vvp TESTBENCH.sv
    vvp jpeg_decoder_sim.vvp
    # gtkwave jpeg_decoder_sim.vcd
   ```

5. Lab09 - Bitcoin Miner
   ``` bash
   cd nycu-vlsi/11_lab09_bitcoin_miner/bitcoin_miner/
   ./01_RTL/01_run
   ./02_SYN/01_run_syn
   ./03_GATE/01_run_Gate
   ```

6. Final Project - Systolic Array
   ``` bash
   cd nycu-vlsi/12_final_systolic_array/systolic_array/
   ./01_RTL/01_run
   ./02_SYN/01_run_syn
   ./02_SYN/01_run_ptpx
   ./03_GATE/01_run_Gate
   ```

## 設計開發環境(Design Environment)
### 製程技術庫 (Process Design Kits, PDKs)
1. 7nm_TT：用於 Lab 01 
2. TSMC 0.18um (T18)：應用於Lab 04, 05, 06 與 Midterm #2
3. ASAP7 (7nm Predictive PDK)：用於 Lab 09 與 Final Project

### EDA 設計工具(EDA Tools)
- 類比電路模擬與佈局 (Analog Design & Layout)：
  - Synopsys HSPICE：用於 Lab 01 的電路層級精確模擬 
  - Cadence Virtuoso：用於 Lab 04, 05, 06 與 Midterm #2 的實體佈局 (Layout) 繪製與驗證

- 數位硬體描述與模擬 (Digital Logic & Verification)
  - Verilog / SystemVerilog：用於 Lab 02, 03, 07, 09 及 Midterm #1, Final Project 的硬體架構實作
  - Cadence irun (Xcelium)：用於 Lab 02, 03, 07, 09 及 Midterm #1, Final Project 作為數位邏輯模擬
  - Icarus Verilog (iverilog) & GTKWave：作為數位邏輯模擬與波形觀測工具

- 數位綜合與佈局 (Synthesis & Implementation)：
  - Synopsys Design Compiler (DC)：用於 Lab 09 及 Final Project 
  - Xilinx Vivado：用於 Final Project