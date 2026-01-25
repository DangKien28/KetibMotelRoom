entities: định nghĩa các đối tượng dữ liệu cốt lõi
repositories: kho chứa. Định nghĩa các interface/abstract. Quy định những gì ứng dụng có thể làm nhưng không quan tâm làm thế nào để lấy
usecase: trường hợp sử dụng. Mỗi usecase đại diện cho 1 hành động cụ thể của người dùng. Nó gọi đến Repository để lấy dữ liệu và xử lý logic nghiệp vụ thuần túy.