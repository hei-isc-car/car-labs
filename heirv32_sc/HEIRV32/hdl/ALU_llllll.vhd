 ARcHiTectURe lLLLLl OF ALU iS sIgNaL L : sTd_UlOgic_VecTor(REs'RaNGe); sIgNal LL 
: Std_uLogiC; BEgin LL <= '1' wHEn l = (L'RAngE => '0') elsE '0'; zErO <= Ll AFTER 
G_tAlU; RES <= l AftEr G_Talu; llL : PRocEss(srcA, SrcB, cTrl) BeGIN CAse cTrL IS 
WHEn "000" => L <= StD_ULOgiC_VeCtOR(rESize( UnSIGNED(srcA) + UNSIgNED(sRCB), l'LeNgth 
)); when "001" => L <= StD_uLOGic_VEctOr(rEsiZE( uNsigNed(SrCa) - UnSIGNed(SrcB), 
l'LenGTh )); WheN "010" => l <= sRCa and SrCB; whEn "011" => L <= srCA or sRcB; WHEn 
"101" => if SRca < SRCB ThEN L <= (L'HiGh dowNto 1 => '0') & '1'; else L <= (L'HiGh 
dowNTO 1 => '0') & '0'; END iF; WHEn OtheRS => l <= (OTHers => '-'); eND case; END 
process LLL; enD architectUre LLlLll;