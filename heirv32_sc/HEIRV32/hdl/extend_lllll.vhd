ARCHITECtURe llLlL of eXTEnD iS SignAl lL : STd_ULOgIC_vECToR(1 DOwNTO 0); Signal 
LLll: Std_uLoGiC_vECTor(ExTeNDEd'range); BegIn ExTeNDEd<=llll;
 Lll : pROceSs(InPUt, lL) BEgIN CaSE lL iS when "00" => Llll <= (12 to 31 => InPuT(
31)) & inPUT(31 DoWNTo 20) AFtEr g_tEXt; WHEn "01" => lllL <= (12 To 31 => iNput(
31)) & INpUT(31 dOwnTO 25) & iNPUT(11 dOWNto 7) AFTer G_TexT; WhEn "10" => LLLL <= 
(12 TO 31 => INPuT(31)) & inPUt(7) & inpUT(30 dowNTo 25) & Input(11 DoWNTo 8) & '0' 
AFTer g_Text; wHEn "11" => LLLl <= (20 to 31 => InPuT(31)) & InPUt(19 dOWntO 12) 
& INPuT(20) & inpuT(30 DownTo 21) & '0' AfTeR g_tExT; WHen Others => llLl <= (oThERS 
=> '-') AFtEr G_TeXT; eND cASE; END PRoCess lll; lL <= SRc; END arChItecture LLLlL;