#Project Overview
<p>My project governs the study of semiconductor devices and more specifically examines the ideal diode equation and its many parameters. The equation for the current across an ideal diode can be given by <img src="https://latex.codecogs.com/svg.image?&space;I=I_0*{(e^{\frac{qv}{kT}}-1)}" />, with I_0 as the saturation current of the diode, q & k as physical constants with electron charge and Boltzmann's constant respectively, V being the applied voltage across the diode and T as temperature. This is a non-linear equation that can be altered with another physical constant n, the ideality of the diode, with the form <img src="https://latex.codecogs.com/svg.image?&space;I=I_0*{(e^{\frac{qv}{nkT}}-1)}" /> . Diodes and semiconductor devices control almost every aspect of the technology that governs our lives, but the underlying physics is not always directly understood. One way of understanding the electric properties of devices is by characterizing them with I-V curves. While many people are familiar with resistors, which can be described by Ohm's law, their I-V curves are also easier to understand, with the slope equal to their resistance. Diodes are not ohmic in nature, however. The goal of my project is to help the understanding of the operation of certain semiconductor devices in a way that is useful to the user and proceed with both theoretical and practical insight. My project is divided into three main categories, exploring temperature dependence, altering the parameters of the device, and interpolating diode data.</p>

##Temperature Dependence
<p>The result of the first option in the code is looking at the IV curve of a diode as a function of temperature, given by a 3D plot. The input vectors can be adjusted to different ranges for temperature and voltage applied. It can be seen that the increase in temperature increases the voltage needed to saturate the diode.</p>
 




##Changing Parameters
<p>This section of the code allows both the ideality and saturation current of the diode to be adjusted, both of which are dependent on material quality, type of diode, and many factors. This brings up a GUI for the user and is a very interactive way to gain insight. By altering the diode_exported_Bernstein.m file, the values of all the parameters can be changed as well. It also shows a reverse voltage breakdown, with the user able to adjust the threshold voltage in the code as well. </p>


 



##Interpolation of Data

<p>The interpolation of data uses data given for three diodes, for both current and voltage. The data is plotted and interpolated using the  intrpf.m, which uses the lagrange polynomial interpolation method. This section connects the simulation with real data, visualizing against the other curves shown in the previous sections of the code. The interpolation can be done with any set of data, not just the diode data given.</p>


