#Laboratórna úloha číslo 1

## GitHub 1:

Link repozitára: https://github.com/DaNNym99/Digital-electronics-1

## De Morgánove zákony 2:

Program vhdl :

```vhdl
architecture dataflow of gates is
begin
    f_o  <= ((not b_i)and a_i) or ((not c_i) and (not b_i));
    fnand_o <= (('1' nand b_i) nand a_i) nand (('1' nand c_i) nand ('1' nand b_i));
    fnor_o <= '0' nor ((b_i nor ('0' nor a_i)) nor (c_i nor b_i));

end architecture dataflow;
```

Link pre edaplayground (De Morgánove zákony): https://www.edaplayground.com/x/aXrz

Výstup s programu edaplayground:
| **c** | **b** |**a** | **f(c,b,a)** | **fNAND(c,b,a)** | **fNOR(c,b,a)** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 1 | 1 | 1 |
| 0 | 1 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 0 | 0 |
| 1 | 1 | 1 | 0 | 0 | 0 |

Obrázok výstupu:

![Screenshot od EDA Playground DML](Images/DML.png)


https://www.edaplayground.com/x/8MeM
