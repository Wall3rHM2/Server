if SERVER then
 util.AddNetworkString( "SDrugsDeath" )

 hook.Add("PlayerDeath","SDrugsDeath",function(ply)
  net.Start("SDrugsDeath")
  net.WriteEntity(ply)
  net.Send(ply)
 end)

 hook.Add("PlayerSilentDeath","SDrugsDeath",function(ply)
  net.Start("SDrugsDeath")
  net.WriteEntity(ply)
  net.Send(ply)
 end)
end