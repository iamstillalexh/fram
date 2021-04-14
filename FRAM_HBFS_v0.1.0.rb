# FRAM_HBFS v0.1.0
# written by Alex Hauptmann
# for Sonic Pi v3.3.1
# last updated 04/14/21

# This program requires FRAM_v0.2.0 loaded
# in another buffer to run. It still doesn't
# sound Great but at least it's trying

set_sched_ahead_time! 2

use_bpm 123

# phrase dictionary!
define :work_it do |note1, note2|
  klatt_diphones note1, 0, "OO", "ER", 0, 1, 0.125/2, 0.5
  sleep 0.5
  klatt_diphones note2, "K", "IH", "IH", "T", 0, 0.25, 0.5
end

define :make_it do |note1, note2|
  klatt_diphones note1, 0, "MM", "EH", 0, 0, 0.125, 0.5
  sleep 0.5
  klatt_diphones note2, "K", "IH", "IH", "T", 0, 0.25, 0.5
end

define :do_it do |note1, note2|
  klatt_diphones note1, "D", "OO", "OO", 0, 0, 0.25, 0.5
  sleep 0.25
  klatt_diphones note2, 0, "IH", "IH", "T", 0, 0.25, 0.5
end

define :makes_us do |note1, note2|
  klatt_diphones note1, 0, "MM", "EH", 0, 0, 0.125, 0.5 # using "K" as end_consonant seems to mess with "EH" formant values here??
  sleep 0.5
  klatt_diphones note2, "S", "UH", "UH", "S", 0, 0.25, 0.5
end

define :harder do |note1, note2|
  klatt_diphones note1, "H", "AH", "AH", 0, 0, 0.25, 0.5
  sleep 0.4
  klatt_diphones note2, "D", "ER", "ER", 0, 0, 0.25, 0.5
end

define :better do |note1, note2|
  klatt_diphones note1, "B", "EH", "EH", 0, 0, 0.25, 0.5
  sleep 0.4
  klatt_diphones note2, "D", "ER", "ER", 0, 0, 0.25, 0.5
end

define :faster do |note1, note2|
  klatt_diphones note1, "F", "AE", "AE", "S", 0, 0.25, 0.4
  sleep 0.4
  klatt_diphones note2, "D", "ER", "ER", 0, 0, 0.25, 0.5
end

define :stronger do |note1, note2| # sronker
  klatt_diphones note1, "S", "ER", "AW", 0, 0, 0.25, 0.4
  sleep 0.4
  klatt_diphones note2, "K", "ER", "ER", 0, 0, 0.25, 0.5
end



# drums
define :daftBeat_1 do
  2.times do
    sample :bd_ada
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 0.5
    sample :bd_ada
    sample :drum_snare_hard
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 0.5
    sample :bd_ada
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 0.5
    sample :bd_ada
    sample :drum_snare_hard
    sample :perc_snap
    sample :perc_snap2 # layering two snaps. no clap samples? bummer
    sleep 0.5
    sample :drum_cymbal_open, finish: 0.25, amp: 0.5
    sleep 0.5
  end
end

define :daftBeat_2 do
  2.times do # wish there was a way to indent multiple lines of code non-manually
    sample :bd_ada
    sample :drum_cymbal_soft
    sleep 0.5
    sample :glitch_perc1, finish: 0.2, amp: 0.25
    sleep 0.5
    sample :bd_ada
    sample :drum_snare_hard
    sample :drum_cymbal_soft
    sleep 0.5
    sample :glitch_perc1, finish: 0.2, amp: 0.25
    sleep 0.5
    sample :bd_ada
    sample :drum_cymbal_soft
    sleep 0.5
    sample :glitch_perc1, finish: 0.2, amp: 0.25
    sleep 0.5
    sample :bd_ada
    sample :drum_snare_hard
    sample :perc_snap
    sample :perc_snap2
    sample :drum_cymbal_soft
    sleep 0.5
    sample :glitch_perc1, finish: 0.2, amp: 0.25
    sleep 0.5
  end
end

define :daftBeat_3 do
  2.times do
    sleep 1
    sample :bd_ada
    sample :drum_snare_hard
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 1.5
    sample :bd_ada
    sample :drum_snare_hard
    sample :perc_snap
    sample :perc_snap2 # layering two snaps. no clap samples? bummer
    sleep 0.5
    sample :drum_cymbal_open, finish: 0.25, amp: 0.5
    sleep 0.5
  end
end

define :daftBeat_4 do
  4.times do
    sample :bd_ada
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 1.5
  end
end

define :daftBass_1 do
  use_synth :pulse
  use_synth_defaults release: 0.5, pulse_width: 0.25, amp: 0.75
  with_fx :ixi_techno, phase: 3, cutoff_min: 62, cutoff_max: 100 do
    play 42
    sleep 0.5
    play 54
    sleep 1.5
    play 40
    sleep 0.5
    play 52
    sleep 1.5
    play 38
    sleep 0.5
    play 50
    sleep 1.5
    play 37
    sleep 0.5
    play 49
    sleep 1.5
  end
end
define :daftBass_2 do
  use_synth :pulse
  use_synth_defaults release: 0.5, pulse_width: 0.25, amp: 0.75
  with_fx :ixi_techno, phase: 3, cutoff_min: 62, cutoff_max: 100 do
    play 35
    sleep 0.5
    play 47
    sleep 1.25
    play 47
    sleep 0.75
    play 47
    sleep 0.5
    play 47
    sleep 0.25
    play 35
    sleep 0.5
    play 47
    sleep 2.75
    play 45
    sleep 0.25
    play 47
    sleep 0.75
    play 35
    sleep 0.5
  end
end

# chords
in_thread do
  use_synth :rodeo
  use_synth_defaults decay: 0.2, sustain: 0, release: 0.25, amp: 0.6
  loop do
    sleep 0.5
    play_chord [61, 66, 68]
    sleep 2
    play_chord [61, 66, 69]
    sleep 2
    play_chord [66, 73]
    sleep 2
    play_chord [73, 78]
    sleep 2
    play_chord [73, 75]
    sleep 3
    play_chord [73, 75, 78]
    sleep 2.5
    play_chord [61, 66, 69]
    sleep 2
  end
end

# guitar
in_thread do
  use_synth :pluck
  loop do
    sleep 4.5
    play_chord [69, 81]
    sleep 0.5
    play_chord [71, 83]
    sleep 0.25
    play_chord [69, 81]
    sleep 10.75
  end
end

# beat
in_thread do
  2.times do
    daftBeat_1
    daftBeat_2
  end
  2.times do
    daftBeat_3
    daftBeat_2
    daftBeat_4
    daftBeat_2
  end
end

# bass
in_thread do
  2.times do
    daftBass_1
    daftBass_2
  end
  2.times do
    sleep 8
    daftBass_2
    daftBass_1
    daftBass_2
  end
end

# vox
in_thread do
  sleep 32
  work_it 42, 42
  sleep 0.5
  make_it 54, 54
  sleep 1
  do_it 45, 45
  sleep 0.5
  makes_us 57, 57
  sleep 10
  harder 61, 59
  sleep 1
  better 59, 57
  sleep 1
  faster 56, 54
  sleep 1
  stronger 49, 47
end
