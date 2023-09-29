from math import pi,tan,sin,atan,cos
import math


print(pi)

lamda = 650   * pow(10,-9) # meters
D     = 216.7 * pow(10,-2) # meters
alpha = 11 *pi/180         # radian            

print(alpha)


#readings
x_m_list    = [  

                0.004,
                0.006,
                0.009,
                0.013,

                0.016,
                0.020,
                0.022,
                0.024,

                0.027,
                0.031
            ] 
# meters


# results array
pitch_list  = []
radius_list = []
theta_list  = []
d_m_list    = []


m=1
for x_m in x_m_list :
    theta  = atan(x_m * m / D)
    theta_list.append(theta)
    d_m    = m*lamda/tan(theta)
    d_m_list.append(d_m)
    pitch  = d_m / cos(alpha)
    radius = pitch*tan( (pi/2) - alpha) / (2*pi)  #since there is no cot function in math lib
    pitch_list .append(pitch)
    radius_list.append(radius)
    m+=1


for i in range(len(x_m_list)):
    print(f'Theta for m={i+1} x={x_m_list[i]}   ----> {theta_list[i]}')

print('\n\n')

for i in range(len(x_m_list)):
    print(f'Pitch for m={i+1} x={x_m_list[i]}   ----> {radius_list[i]}')

print('\n\n')

for i in range(len(x_m_list)):
    print(f'Radius for m={i+1} x={x_m_list[i]}  ----> {pitch_list[i]}')

print('\n\n')



print(sum(pitch_list) / len(x_m_list))                                                                                                                                                                     
print(sum(radius_list) / len(x_m_list))                                                                                                                                                                     



'''

m        x       theta       Pitch (cm)   Radius (cm)

1       0.003     0.00138    0.0391626    0.0258728, 
2       0.006     0.00553    0.0195813    0.0239152,  
3       0.009     0.01245    0.0130542    0.0159434,  
4       0.013     0.02399    0.0090375    0.0150377,  
5       0.016     0.03690    0.0073430    0.0189682,  
6       0.020     0.05531    0.0058744    0.0171745,  
7       0.022     0.07094    0.0053403    0.0165223,  
8       0.024     0.08837    0.0048953    0.0159788,  
9       0.027     0.11167    0.0043514    0.0153144,  
10      0.031     0.14209    0.0037899    0.0146287,  


R_average         =     0.017935 cm 
thickness         =     0.471252 mm



0.00010263




'''