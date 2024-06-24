<?php
namespace App\Services;

use App\Models\User;

class UserService {
    public function getAllUsers() {
        return User::all();
    }

    public function getAllUsersByDate() {
        $data = User::selectRaw("to_char(created_at, 'YYYY-Mon-DD') as date, count(*) as aggregate")
            ->whereDate('created_at', '>=', now()->subDays(30))
            ->groupBy('date')
            ->get();
        return $data;
    }

    public function getAllUsersWithPagination() {
        $users = User::paginate(8);
        $users->withPath('admin?activeLink=users&panelAction=allUsers');
        return $users;
    }


    public function getUserById(string $id) {
        return User::query()->find($id);
    }

    public function deleteUserById(string $id) {
        return User::destroy($id);
    }
}
