package org.example;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.util.ArrayList;

public class App
{
    public static void main( String[] args )
    {
        UserService service = new UserService();
        ArrayList<User> listUser = service.getAllUser();
        listUser.forEach(i -> System.out.println(i));

        service.insert();

        User fUser = service.getUserById(2);
        System.out.println(fUser);

        service.updatePassword(fUser, "1234567888");
        System.out.println(fUser);

        User fU = service.getUserById(1);
        System.out.println(fU);
        service.deleteUser(fU);

        //Mã hóa password
//        String password = "123456789";
//        String encode = BCrypt.hashpw(password, BCrypt.gensalt(12));
//        System.out.println(encode);
//
//        System.out.println(BCrypt.checkpw(password, encode));
    }
}
