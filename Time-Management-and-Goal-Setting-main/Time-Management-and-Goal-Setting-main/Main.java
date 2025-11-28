package com.timemanagement;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        GoalManager manager = new GoalManager();

        while (true) {
            System.out.println("1. Add Goal");
            System.out.println("2. Add Task");
            System.out.println("3. Complete Goal");
            System.out.println("4. View Goals");
            System.out.println("5. View Tasks");
            System.out.println("6. Exit");
            System.out.print("Choose an option: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline

            switch (choice) {
                case 1:
                    System.out.print("Enter goal description: ");
                    String goalDesc = scanner.nextLine();
                    manager.addGoal(new Goal(goalDesc));
                    break;
                case 2:
                    System.out.print("Enter task description: ");
                    String taskDesc = scanner.nextLine();
                    Task task = new Task(taskDesc);
                    System.out.print("Enter time spent in minutes: ");
                    int timeSpent = scanner.nextInt();
                    task.addTime(timeSpent);
                    manager.addTask(task);
                    break;
                case 3:
                    manager.printGoals();
                    System.out.print("Enter goal number to complete: ");
                    int goalIndex = scanner.nextInt() - 1;
                    manager.completeGoal(goalIndex);
                    break;
                case 4:
                    manager.printGoals();
                    break;
                case 5:
                    manager.printTasks();
                    break;
                case 6:
                    System.out.println("Exiting...");
                    scanner.close();
                    return;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
}
