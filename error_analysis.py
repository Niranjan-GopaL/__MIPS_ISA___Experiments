from math import sqrt


radius_list = [
    2.58728,
    2.39152,
    1.59434,
    1.50377,
    1.89682,
    1.71745,
    1.65223,
    1.59788,
    1.53144,
    1.46287,
]


radius_average = sum(radius_list) / 10
print(f'Average radius = {radius_average}')

abs_diff_radius_avg = [ abs( i - radius_average) for i in radius_list]

print("\n\n===== abs_difference_radius_from_average_radius ======\n")
for i in abs_diff_radius_avg:
    print(f'{i:.4f}  ')

print('\n\n\n')
sum_sq_distance_by_n = sum([i*i for i in abs_diff_radius_avg]) / 10
print(f'sum of sq of distances = {sum_sq_distance_by_n:.4f} ')


standard_deviation = sqrt(sum_sq_distance_by_n)
print(f'standard_deviation = {standard_deviation:.4f}')


standard_error_of_arithmatic_mean = standard_deviation / sqrt(5)
print(f'standard_error_of_arithmatic_mean = {standard_error_of_arithmatic_mean:.4f}')


percentage_error = standard_error_of_arithmatic_mean / radius_average * 100
print(f'percetnage error = {percentage_error:.4f}')



