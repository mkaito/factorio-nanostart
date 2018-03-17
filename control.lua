script.on_event(defines.events.on_player_created, function(event)
  local player = game.players[event.player_index]
  local guns = player.get_inventory(defines.inventory.player_guns)

  local equip = settings.get_player_settings(game.players[event.player_index])["nanostart-equip"].value
  local emitters = settings.get_player_settings(game.players[event.player_index])["nanostart-emitters"].value
  local constructor_stacks = settings.get_player_settings(game.players[event.player_index])["nanostart-constructor-stacks"].value
  local termite_stacks = settings.get_player_settings(game.players[event.player_index])["nanostart-termite-stacks"].value

  local constructors = constructor_stacks * 100
  local termites = termite_stacks * 100

  -- Check for sandbox mode... or any mode without a player body.
  if (not player.character or not player.get_inventory(5)) then
    return
  end

  if equip then
    if constructors > 100 and termites > 100 then
      if emitters >= 1 then
        guns.insert("gun-nano-emitter")
      end

      player.insert{ name="ammo-nano-constructors", count = constructors }

      if emitters >= 2 then
        guns.insert("gun-nano-emitter")
      end

      player.insert{ name="ammo-nano-termites", count = termites }

      if emitters >= 3 then
        player.insert{ name = "gun-nano-emitter", count = (emitters - 2) }
      end
    end
  else
    player.insert{ name="ammo-nano-termites", count = termites }
    player.insert{ name="ammo-nano-constructors", count = constructors }
    player.insert{ name="gun-nano-emitter", count = emitters }
  end
end)
