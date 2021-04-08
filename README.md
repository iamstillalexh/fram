# fram
Cascade formant synthesizer written in Sonic Pi

# DISCLAIMERS
Fram is written IN Sonic Pi. It is NOT a synth engine, it is merely a front-end Ruby script to be run as any other Sonic Pi code.

# "Fram??"
"Formant Related Articulatory Module".

# "That's absolutely a backronym, isn't it?"
Yep.

# So...how does it work, anyw--
I'M GLAD YOU ASKED!! Basically the way this thing works is that a buzz source goes into three band pass filters in series, which is a…very oversimplified model of how the human vocal tract works. The first series filter tends to have the lowest cutoff frequency (notated as “F1” in speech analysis), and it seems to model the part of the throat immediately above the vocal cords, hence why I used it to model the “H” sound with pink noise. The second filter (F2) tends to have a higher formant than F1, and it approximates position of the mouth and tongue. The final filter (F3) is the highest in its formant frequency, and seems to be the best place to model sibilance, fricatives and plosives (aka the stuff you do with your lips when you talk).

# I guess this would be impressive if it was 1974.
Yeah basically.
