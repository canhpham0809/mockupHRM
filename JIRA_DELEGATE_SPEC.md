# Tài liệu Chức năng Ủy quyền (Delegation Management)

## I. MÀN HÌNH 1: DANH SÁCH ỦY QUYỀN

> **Tham khảo UI**:  Kết hợp mục B

### A. CHỨC NĂNG CHÍNH

- Hiển thị danh sách tất cả ủy quyền đang có trên hệ thống
- Tìm kiếm và lọc theo: 
  - Người ủy quyền
  - Người được ủy quyền
  - Trạng thái kích hoạt
  - Trạng thái hiệu lực
- Phân trang **10 bản ghi/trang**
- Tạo mới ủy quyền
- Xem chi tiết ủy quyền

---

### B. DANH SÁCH CỘT TRONG BẢNG

| Column Name VI | Column Name EN | Type | Note |
|---|---|---|---|
| STT | STT | Text | Thứ tự bản ghi |
| Người ủy quyền | Delegator | Text | Chỉ hiển thị tên |
| Người được ủy quyền | Delegatee | Text | Chỉ hiển thị tên |
| Thời gian ủy quyền | Time | Text | Format: `HH:MM:SS DD/MM/YYYY - HH:MM:SS DD/MM/YYYY` hoặc "Vô thời hạn / Unlimited" |
| Quy trình | Workflow | Text | Danh sách quy trình (mỗi dòng một item) nếu dài quá thì hiện tooltip … |
| Trạng thái | Status | Text | **Active**:  màu xanh<br>**Inactive**: màu đỏ |
| Hiệu lực | Effective | Text | **Đang hiệu lực / Effective**: Màu xanh<br>**Hết hiệu lực / Expired**:  Màu đỏ<br>**Vô thời hạn / Unlimited**:  Màu vàng |
| Ngày tạo | Created Date | Date | Format: `HH:MM:SS DD/MM/YYYY` |
| Thời gian cập nhật | Updated Date | Date | Format: `HH:MM:SS DD/MM/YYYY` |
| Người cập nhật | Updated By | Text | Tên người cập nhật cuối cùng |

---

### C.  SEARCH / FILTER

#### **Fulltext Search theo:**
- **Field Search**: Search theo Fullname/domain người ủy quyền/người được ủy quyền

#### **Filter theo:**
- **Trạng thái**:  Dropdown (Tất cả / Active / Inactive)
- **Trạng thái hiệu lực**: Dropdown (Tất cả / Còn hạn / Hết hạn / Vô thời hạn)

---

### E. ACTION

- **Click button Create**: chuyển sang màn hình tạo mới
- **Click xem chi tiết dòng data**:  chuyển sang màn hình xem chi tiết / update

---

## II. MÀN HÌNH 2: FORM TẠO/CHỈNH SỬA ỦY QUYỀN

> **Mockup URL**: https://canhpham0809.github.io/mockupHRM/delegate_v2.html

### A. CHỨC NĂNG CHÍNH

- Tạo mới một ủy quyền hoặc chỉnh sửa ủy quyền hiện có

---

### B. DANH SÁCH CÁC FIELD

#### **PHẦN 1: NGƯỜI ỦY QUYỀN**

| Field | Name VI | Name EN | Type | Validate | Logic/Ghi chú |
|---|---|---|---|---|---|
| Người ủy quyền | Người ủy quyền | Delegator | Dropdown Select | **Bắt buộc** | Chọn từ danh sách Employee đang active<br>Hiển thị "Tên - Chức vụ" |

---

#### **PHẦN 2: NGƯỜI ĐƯỢC ỦY QUYỀN**

| # | Field | Name VI | Name EN | Type | Validate | Logic/Ghi chú |
|---|---|---|---|---|---|---|
| 1 | Người được ủy quyền | Người được ủy quyền | Delegatee | Dropdown Select | **Bắt buộc** | Chọn từ danh sách Employee đang active<br>Hiển thị "Tên - Chức vụ" |
| 2 | Thời gian ủy quyền | Thời gian ủy quyền | Delegation Time | Radio Button (2 lựa chọn) | **Bắt buộc** | "Có thời hạn" (default) hoặc "Vô thời hạn" |
| 2a | Từ ngày - Đến ngày | Từ ngày - Đến ngày | From Date - To Date | DateTime input (2 fields) | **Bắt buộc nếu "Có thời hạn"** | Hiển thị khi chọn "Có thời hạn"<br>Default từ ngày = ngày hiện tại<br>Đến ngày >= Từ ngày |
| 3 | File ủy quyền | File ủy quyền | Delegation File | Upload (Drag & Drop) | Optional | Accept: PDF, DOC, DOCX, PNG, JPG (max 5MB) |
| 4 | Mô tả | Mô tả | Description | Textarea | Optional | Rows: 3<br>Placeholder: "Nhập mô tả thêm về ủy quyền..." |
| 5 | Kích hoạt | Kích hoạt | Active | Checkbox | N/A | Default:  Checked ✓ |
| 6 | Phạm vi ủy quyền | Phạm vi ủy quyền | Delegation Scope | Checkbox toggle + Table | **Bắt buộc** | Default unchecked:  Hiển thị "All Workflow • All Task"<br>Checked: Hiển thị table với button "+ Thêm dòng" |

---

#### **Phạm vi ủy quyền - Table detail:**

**Hành vi:**
- Click "+ Thêm dòng" → Mở modal
- Mỗi dòng = 1 Workflow + Task + Dynamic Fields
- Click vào row để edit
- Nút Xóa ở cuối dòng

**Columns:**

| Column | Name VI | Name EN | Type | Validate |
|---|---|---|---|---|
| Workflow | Quy trình | Workflow | Text | - |
| Task | Tác vụ | Task | Text (danh sách tasks) | - |
| Other Options | Điều kiện | Other Options | Text (danh sách) | - |
| Action | Thao tác | Action | Xóa button | - |

---

#### **MODAL: Thêm/Sửa dòng Workflow/Task**

| # | Field | Name VI | Name EN | Type | Validate | Logic/Ghi chú |
|---|---|---|---|---|---|---|
| 1 | Workflow | Quy trình | Workflow | Dropdown Select | **Bắt buộc** | Auto-select "All Tasks" khi chọn WF<br>Ẩn WF đã chọn (khi thêm mới) |
| 2 | Task | Tác vụ | Task | Checkbox list + "All Tasks" | **Bắt buộc ≥1** | Default:  All Tasks checked<br>Danh sách từ Workflow mapping |
| 3 | Other Options | Trường động | Other Options | Multi-select Dropdown | Optional | Phụ thuộc Workflow (xem Workflow mapping)<br>Mỗi field là checkbox dropdown có giá trị riêng |

**Modal Buttons:**

| Button | Name VI | Name EN | Action | Validate |
|---|---|---|---|---|
| Hủy | Hủy | Cancel | Đóng modal | - |
| Xóa | Xóa | Delete | Xóa dòng | Hiển thị khi **edit mode**, ẩn khi **add mode** |
| Thêm / Cập nhật | Thêm / Cập nhật | Add / Update | Lưu dòng | - |

---

#### **PHẦN 3: BUTTONS TẠI BOTTOM OF FORM**

| Button | Name VI | Name EN | Action | Validate |
|---|---|---|---|---|
| Đóng | Đóng | Close | Quay lại danh sách | Confirm nếu có thay đổi chưa lưu |
| Lưu | Lưu | Save | Lưu lại | Validate toàn bộ form (xem mục E) |

---