local audio_path = 'data/audio/'

local function new_sound(path, volume, pitch)
  return {
    volume = volume or 1,
    pitch = pitch or 1,
    source = love.audio.newSource (audio_path .. path, 'static'),
    is_sound = true
  }
end

local function new_music(path, volume, pitch)
  return {
    volume = volume or 1,
    pitch = pitch or 1,
    source = love.audio.newSource (audio_path .. path, 'stream'),
    is_sound = true
  }
end

local sounds =
{

  forest_floor_ambience = new_music('forest_floor/forest_floor_ambience.mp3', 0.4, 0.8),
  angstrom_industries = new_music('republic/Angstrom_Industries.mp3', 0.2, 0.8),
  learning_center = new_music('learning_center/robots_balad.ogg', 0.1, 1),
  turing_test = new_music('turing_test/Gears_of_ Fate.mp3', 0.2, 0.9),
  intro = new_music('melon.ogg', 0.5, 0.3),
  
  data_noises = 
  {
    new_sound('forest_floor/set_01/set_1_01.ogg', 0.05, 0.5),
    new_sound('forest_floor/set_01/set_1_02.ogg', 0.05, 0.5),
    new_sound('forest_floor/set_01/set_1_03.ogg', 0.05, 0.3),
    new_sound('forest_floor/set_01/set_1_04.ogg', 0.05, 0.3),
    new_sound('forest_floor/set_01/set_1_05.ogg', 0.05, 0.1),
    new_sound('forest_floor/set_01/set_1_06.ogg', 0.05, 0.1),
    new_sound('forest_floor/set_01/set_1_07.ogg', 0.05, 0.15),
    new_sound('forest_floor/set_01/set_1_08.ogg', 0.05, 0.15),
    new_sound('forest_floor/set_01/set_1_09.ogg', 0.05, 0.2),
    new_sound('forest_floor/set_01/set_1_10.ogg', 0.05, 0.2),
    new_sound('forest_floor/set_01/set_1_11.ogg', 0.05, 0.1),
    new_sound('forest_floor/set_01/set_1_12.ogg', 0.05, 0.1),
  },

  signals = 
  {
    new_sound('forest_floor/set_02/set_02_01.ogg', 0.05, 5),
    new_sound('forest_floor/set_02/set_02_02.ogg', 0.05, 5),
    new_sound('forest_floor/set_02/set_02_03.ogg', 0.05, 4),
    new_sound('forest_floor/set_02/set_02_04.ogg', 0.05, 4),
    new_sound('forest_floor/set_02/set_02_05.ogg', 0.05, 3),
    new_sound('forest_floor/set_02/set_02_06.ogg', 0.05, 3),
    new_sound('forest_floor/set_02/set_02_07.ogg', 0.05, 4),
    new_sound('forest_floor/set_02/set_02_08.ogg', 0.05, 4),
    new_sound('forest_floor/set_02/set_02_09.ogg', 0.05, 2),
    new_sound('forest_floor/set_02/set_02_10.ogg', 0.05, 2),
    new_sound('forest_floor/set_02/set_02_11.ogg', 0.05, 2),
    new_sound('forest_floor/set_02/set_02_12.ogg', 0.05, 2),
    new_sound('forest_floor/set_02/set_02_13.ogg', 0.05, 2),
    new_sound('forest_floor/set_02/set_02_14.ogg', 0.05, 2),
  },

  bird_flap = 
  {
    new_sound('forest_floor/bird_flap_1.ogg', 0.25, 1.0),
    new_sound('forest_floor/bird_flap_2.ogg', 0.25, 1.0),
    new_sound('forest_floor/bird_flap_3.ogg', 0.25, 1.0),
    new_sound('forest_floor/bird_flap_4.ogg', 0.25, 1.0),
  },

  leaves_rustling = 
  {
      new_sound('forest_floor/leaves_rustling_1.ogg', 0.2, 0.7),
      new_sound('forest_floor/leaves_rustling_2.ogg', 0.2, 0.7),
  },

  pool = 
  {
      new_sound('forest_floor/pool_1.ogg', 0.1, 0.8),
      new_sound('forest_floor/pool_2.ogg', 0.1, 0.8),
      new_sound('forest_floor/pool_3.ogg', 0.1, 0.8),
  },

  drops = 
  {
      new_sound('forest_floor/rain_1.ogg', 0.2, 1.2),
      new_sound('forest_floor/rain_2.ogg', 0.2, 1.2),
      new_sound('forest_floor/rain_3.ogg', 0.2, 1.2),
      new_sound('forest_floor/rain_4.ogg', 0.2, 1.2),
  },

  whos_there = 
  {
      new_sound('forest_floor/whos_there_1.ogg', 0.1, 0.8),
      new_sound('forest_floor/whos_there_1.ogg', 0.1, 0.9),
      new_sound('forest_floor/whos_there_2.ogg', 0.1, 1.0),
      new_sound('forest_floor/whos_there_2.ogg', 0.1, 1.1),
      new_sound('forest_floor/whos_there_3.ogg', 0.1, 0.7),
      new_sound('forest_floor/whos_there_3.ogg', 0.1, 0.8),
      new_sound('forest_floor/whos_there_4.ogg', 0.1, 0.9),
      new_sound('forest_floor/whos_there_4.ogg', 0.1, 1.0),
      
  },

    rain_ambient = new_music('forest_floor/rain_ambient_2_short.mp3', 0.1, 1),
    forest_floor = new_sound('forest_floor/forest_floor.ogg', 0.5, 0.8),
    --learning_center = new_sound('learning_center/learning_center.ogg', 0.5, 0.8),
    high_terrace_ambient = new_music('high_terrace/data_beam.ogg', 0.4, 1),
    high_terrace_ambient_1 = new_music('high_terrace/data_beam_2.ogg', 0.4, 3),
    high_terrace_ambient_2 = new_music('high_terrace/data_beam_3.ogg', 0.4, 0.5),
    
    high_terrace_beam_2 = 
  {
    new_sound('high_terrace/data_beam_2_1.mp3', 0.3, 1),
    new_sound('high_terrace/data_beam_2_1.mp3', 0.3, 1.2),
    new_sound('high_terrace/data_beam_2_1.mp3', 0.3, 1.5),
    new_sound('high_terrace/data_beam_2_1.mp3', 0.3, 2),
    new_sound('high_terrace/data_beam_2_1.mp3', 0.3, 2.5),
    new_sound('high_terrace/data_beam_2_1.mp3', 0.3, 3),
    },

  --high_terrace_beam_2 = new_music('high_terrace/data_high_loop.ogg', 0.4, 1.5),

  blip = {
    new_sound('blip.ogg', 0.05, 1),
    new_sound('blip.ogg', 0.05, 1.2),
    new_sound('blip.ogg', 0.05, 1.5),
    new_sound('blip.ogg', 0.05, 2),
    new_sound('blip.ogg', 0.05, 2.5),
    new_sound('blip.ogg', 0.05, 3)
  },

  --boot_up_sequence = new_music('boot_up_sequence_2.ogg', 0.5, 1.2),

  stone = new_sound ('stone.ogg', 0.2, 1),
  
  melon_dark = new_music('melon_dark.ogg', 1, 1),
}

return sounds
