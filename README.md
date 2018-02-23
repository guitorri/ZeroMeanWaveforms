# ZeroMeanWaveforms
LTSpice models for modelling neural stimulation waveforms


This repository contains files for modelling neural stimulation waveforms. The motivation is set out in a paper due to be published on biorxiv at ....

Getting started:

1) Download & install the free electrical circuit simulator LTSpice from http://www.linear.com/designtools/software/ 

2) Clone (or Download & extract) this repository to your computer

3) Open ltspice and open "Full.asc"

4) Run the simulation (click the icon of a man running)

5) LTSpice will run 2 simulations, one with a triphasic waveform and one with a biphasic waveform and plot the voltage results from key nodes and the current through the component modelling faradaic resistance. 

6) If you go to "View -> Spice error log" and scroll down to near the bottom, you will see the results of 2 measurements: net charge imbalance and net faradaic current.

If you would like to change the model, then you will need to know/learn a little about LTSpice:
 http://www.simonbramble.co.uk/lt_spice/ltspice_lt_spice.htm
 http://cds.linear.com/docs/en/software-and-simulation/LTspiceGettingStartedGuide.pdf

The model is fully parameterised (the text written on the schematic). See the picture "parameter_description.png" and "Misc_spice_commands". On the top left are the electrode parameters, next to that are parameters controlling whether  DC blocking capacitors are used and whether the electrodes are shorted after stimulation. next to that are the parameters of the stimulation pulse train. The various voltage sources around the bottom and right hand side generate waveforms that are used to drive switches and control the ideal current source used. 


Other models are included - a simple one is the biphasic_triphasic_simple. This one is set up with a biphasic waveform (contained in "biphasic_pwl.txt"), to run it with a triphasic waveform: double click the text saying 'PWL REPEAT FOREVER ..." and change biphasic_pwl.txt to "triphasic_pwl.txt". 

