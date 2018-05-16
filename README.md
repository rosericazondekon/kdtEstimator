KDT Estimator
================
Roseric AZONDEKON
April 21, 2018

Here is a small Shiny application designed specifically for the estimation of Knock-Down Time based on aggregated WHO or CDC bottle Bioassay data. The application is primarily dedicated to Entomologists interested in the study of vector resistance to insecticides. Other scientists interested in the estimation of measures like Lethal Dose 50 (LD50) or Lethal Concentration (LC50) may also use it. This is not a well written documentation. More to come...

Data Format
-----------

This application accepts the dataset either in a .txt, a .csv or **Excel formats (.xls only)**. The first column of the dataset is expected to contain the KDTs and be labeled "KDT". The second column is expected to contain the number of mosquitoes "knocked down" by the insecticide of interest and be labeled "dead", and the third column of the dataset is expected to contain the total number of mosquitoes exposed and be labeled "total". You may have different labels for the expected variables. In case you do, the application will invite you to explicitely specify the variables. I recommend that you use the display below as your template dataset.

| KDT | dead | total |
|:----|:-----|:------|
| 5   | 13   | 100   |
| 10  | 32   | 100   |
| 15  | 39   | 100   |
| 20  | 47   | 100   |
| 30  | 57   | 100   |
| 40  | 67   | 100   |
| 50  | 81   | 100   |
| 60  | 98   | 100   |

Very Short Description
----------------------

This Shiny Application has been designed designed to specifically estimate KD50, KD90, and KD95 corresponding respectively to the estimated time (usually in minutes), the insecticide of interest will take to "knock down" 50%, 90%, and 95% of the exposed mosquitoes. The application has a side bar which can help the user display the documentation, load his dataset, choose an appropriate link function, and indicate the variables required for the estimation. In the main body of the application, there are four tabs. The first, the "Results" tab presents the results of the estimation, the "Model Summary" tab displays the summary of the fitted model, the third tab helps the user preview his data, and the last tab serves as the documentation for the app and is titled "README".

Now, enough with the long speech, Enjoy my application and should you have any suggestion, critique, and/or recommendation, feel free to contact me at <roseric_2000@yahoo.fr> or check my [Github Page](https://github.com/rosericazondekon) if you are interested in the code (I will be posting it very soon!).

Thank You!

Roseric Azondekon

~
=

Last revision: April 23, 2018
