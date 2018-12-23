--[[###############################################################################
################RDPI - Respondedor de Perguntas Idiotas############################
###############################################################################]]--
if SERVER then
 util.AddNetworkString("RPDIResult")
 local Perguntas={
    {"o server e br","o server é br","br","server br","server é br","|c|esse server é br","Esse server ".. utf8.char(233) .." BR."},
    {"como voa","como faz pra voar","como liga noclip","noclip não ta funcionando","noclip nao ta funcionando","Digite !build no chat e depois clique a tecla v."},
    {"como entra no build","|c|como liga build","|lc|como entra em build","|c|como entra em builder","|c|virar builder","Digite !build no chat."},
    {"|c|me ensina a jogar","|lc|como eu jogo isso","|c| como jogar","como joga isso","como joga","Entre nesse link pelo seu navegador para aprender a jogar: bit.ly/2Qe4O7P"}  
  
 }
 local function ManageResult(ply,resposta) 
  net.Start("RPDIResult") 
  net.WriteString(resposta)
  net.Broadcast()
 end
 local function RPDI(ply,text,teamChat)
  for I=1,#Perguntas do
   local Resposta=Perguntas[I][#Perguntas[I]]
   for i=1,(#Perguntas[I]-1) do
    local fText=string.gsub( string.lower(text), " ","")
    local fPergunta=string.gsub( string.lower(Perguntas[I][i]) ," ","")
    if string.EndsWith(fText,"?") then fText=string.gsub(fText,"?","")
     if string.find(fPergunta,"|c|") then fPergunta=string.gsub(fPergunta,"|c|","")
      if string.find(fText,fPergunta) then ManageResult(ply,Resposta) end
     elseif string.find(fPergunta,"|lc|") then fPergunta=string.gsub(fPergunta,"|lc|","")
      if string.EndsWith(fText,fPergunta) then ManageResult(ply,Resposta) end
     elseif fText==fPergunta then ManageResult(ply,Resposta) end
    end
   end
  end
 end
 hook.Add("PlayerSay","RPDIServer",RPDI)  
end
if CLIENT then
 local Resultados={}
 net.Receive("RPDIResult",function()
  Resultados[1]=net.ReadString()
  timer.Simple(0.1,function()
   chat.AddText(Color(33,225,0),"RPDI",Color(255,255,255),": ".. Resultados[1])
  end)
 end)
end 