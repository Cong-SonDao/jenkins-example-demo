# Sử dụng image nginx chính thức
FROM nginx:alpine

# Sao chép file index.html vào thư mục web mặc định của nginx
COPY index.html /usr/share/nginx/html/index.html

# Expose cổng 80 (mặc định của nginx)
EXPOSE 80
