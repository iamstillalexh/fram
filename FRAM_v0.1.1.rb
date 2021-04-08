# FRAM v0.1.1
# written by Alex Hauptmann
# for Sonic Pi v3.3.1
# last updated 04/08/21

# FRAM is a set of Sonic Pi scripts
# describing and sequencing a cascade
# formant synthesizer to emulate
# speech output. Why? Because I can.

# CHANGELOG
# * Attempting to use "set_sched_ahead_time!" to make sequence timing more consistent (greetz to @xavierriley)
# * THREE NEW WORDS: "Harder", "Better" and "Faster" (no "Stronger" YET because I have NOT optimized this for Consonant Clusters)

use_bpm 65
set_sched_ahead_time! 2

# Simulating vocal cords
# (This can be changed for Sonovox-style effects)
define :voxcords do |note, length|
  use_synth :pulse
  use_synth_defaults pulse_width: 0.1, cutoff: 80, resonance: 0.1 # thin pulse with some rolloff
  play note, duration: length, release: 0.1
end

# Defining a cascade formant filter as described by Dennis Klatt
# "consonant" conditionals are still...problematic at this point
define :klatt do |note, init_consonant, f1_a, f2_a, f3_a, f1_b, f2_b, f3_b, end_consonant, glide, breakpoint, length|
  with_fx :normaliser do # normalizing :bpfs after the series chain decreases distortion
    with_fx :bpf, res: 0.7, centre: f3_a, centre_slide: (glide * breakpoint) do |c3| # lips & teeth
      if init_consonant == "S"
        use_synth :noise
        play 40, cutoff: 130, amp: 0.01, attack: 0.125, decay: 0.125/8, release: 0.125/8
      end
      if init_consonant == "F"
        use_synth :noise
        play 40, cutoff: 90, amp: 0.01, attack: 0.125/2, decay: 0.125/16, release: 0
      end
      if init_consonant == "D"
        use_synth :pnoise
        play 40, cutoff: 130, amp: 0.1, attack: 0, decay: 0.125/16, release: 0.125/8
      end
      if init_consonant == "B"
        use_synth :pnoise
        play 40, cutoff: 70, amp: 0.1, attack: 0, decay: 0.125/16, release: 0.125/8
      end
      
      with_fx :bpf, res: 0.8, centre: f2_a, centre_slide: (glide * breakpoint) do |c2| # tongue
        
        if init_consonant == "K"
          use_synth :pnoise
          play 40, cutoff: 130, amp: 0.5, decay: 0.125/8, release: 0.125/8
        end
        
        with_fx :bpf, res: 0.9, centre: f1_a, centre_slide: (glide * breakpoint) do |c1| # throat
          if init_consonant == "H"
            use_synth :noise
            play 40, cutoff: 130, amp: 0.05, attack: 0.125, decay: 0.125/8, release: 0.125/8
          end
          
          voxcords note, length
          sleep breakpoint # transition to next phoneme
          control c1, centre: f1_b
        end
        control c2, centre: f2_b
        if end_consonant == "K"
          sleep (length*0.9)
          use_synth :pnoise
          play 40, cutoff: 130, amp: 0.5, decay: 0.125/8, release: 0.125/8
        end
        # AUTHOR'S NOTE: ope, I think I know why end_consonant "K" is messing with formant frequencies of the value before it.
        # the way I have this written now probably means that the synth will articulate "K" before it even gets the command
        # to update F3. yeah looks like I'm gonna need to clean up the code's infrastructure before I can add more functionality.
        # such, it seems, is the world of Programming.
      end
      control c3, centre: f3_b
      if end_consonant == "T"
        sleep (length*0.9)
        use_synth :noise
        play 40, cutoff: 130, amp: 0.4, attack: 0, decay: 0.125/8, release: 0.125/8
      end
      if end_consonant == "S"
        sleep (length*0.5)
        use_synth :noise
        play 40, cutoff: 130, res: 0.5, amp: 0.005, attack: 0.125/2, decay: 0.125/8, release: 0.125/8
      end
    end
  end
end

# Table of :bpf centre values to simulate formants
# Formants taken from "Musical Signal Processing with LabVIEW" by Ed Doering
# Rounded to the nearest MIDI note because HAHAHA WHAT THE HECK
define :klatt_vowels do |vowel|
  if vowel == "AW"
    return [99, 80, 74]
  end
  
  if vowel == "OO"
    return [62, 81, 97]
  end
  
  if vowel == "MM"
    return [62, 62, 74] # stabbing in the dark here for formant values of "MM". it sounds. fine for now
  end
  
  if vowel == "OU"
    return [69, 84, 97]
  end
  
  if vowel == "AH"
    return [78, 85, 99]
  end
  
  if vowel == "UH"
    return [72, 86, 98]
  end
  
  if vowel == "ER"
    return [71, 88, 92]
  end
  
  if vowel == "AE"
    return [76, 93, 98]
  end
  
  if vowel == "EH"
    return [72, 94, 99]
  end
  
  if vowel == "IH"
    return [67, 95, 99]
  end
  
  if vowel == "EE"
    return [61, 98, 102]
  end
end

# Definition of input format for phonetic sequencing
# too many functions calling functions? maybe this is inefficient
define :klatt_diphones do |note, init_consonant, diphone1, diphone2, end_consonant, glide, breakpoint, sustain|
  d1 = klatt_vowels diphone1 # [f1, f2, f3] of vowel lookup table
  d2 = klatt_vowels diphone2 # arrays, h*ck yeah
  
  klatt note, init_consonant, d1[0], d1[1], d1[2], d2[0], d2[1], d2[2], end_consonant, glide, breakpoint, sustain
  
end

# Sequencing the phonemes
# NOTE: the phonetic sequence is not optimal here,
# but I've run into problems with the engine forgetting
# how to pronounce vowels after being given initial
# consonant arguments? I may simply need to find
# a more elegant format
klatt_diphones 40, 0, "OO", "ER", 0, 1, 0.125/4, 0.25
sleep 0.25
klatt_diphones 40, "K", "IH", "IH", "T", 0, 0.125, 0.25
sleep 0.5
klatt_diphones 52, 0, "MM", "EH", 0, 0, 0.125/2, 0.25
sleep 0.25
klatt_diphones 52, "K", "IH", "IH", "T", 0, 0.125, 0.25
sleep 0.5
klatt_diphones 43, "D", "OO", "OO", 0, 0, 0.125, 0.25
sleep 0.2 # for some reason i needed to make this "sleep" shorter in order for the next word to not be late??
klatt_diphones 43, 0, "IH", "IH", "T", 0, 0.125, 0.25
sleep 0.5
klatt_diphones 55, 0, "MM", "EH", 0, 0, 0.125/2, 0.25 # using "K" as end_consonant seems to mess with "EH" formant values here??
sleep 0.25
klatt_diphones 55, "S", "UH", "UH", "S", 0, 0.125, 0.25
sleep 0.75
klatt_diphones 59, "H", "AH", "AH", 0, 0, 0.125, 0.25
sleep 0.25
klatt_diphones 57, "D", "ER", "ER", 0, 0, 0.125, 0.25
sleep 0.5
klatt_diphones 57, "B", "EH", "EH", 0, 0, 0.125, 0.25
sleep 0.25
klatt_diphones 55, "D", "ER", "ER", 0, 0, 0.125, 0.25
sleep 0.5
klatt_diphones 54, "F", "AE", "AE", "S", 0, 0.125, 0.2
sleep 0.25
klatt_diphones 52, "D", "ER", "ER", 0, 0, 0.125, 0.25
sleep 0.5
